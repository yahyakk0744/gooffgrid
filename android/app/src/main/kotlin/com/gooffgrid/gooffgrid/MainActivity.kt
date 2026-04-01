package com.gooffgrid.gooffgrid

import android.app.AppOpsManager
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import android.os.Process
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.util.Calendar

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.gooffgrid/screen_time"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "hasPermission" -> result.success(hasUsageStatsPermission())
                "requestPermission" -> {
                    openUsageAccessSettings()
                    result.success(null)
                }
                "getUsageStats" -> {
                    val daysAgo = call.argument<Int>("daysAgo") ?: 0
                    val stats = getUsageStats(daysAgo)
                    result.success(stats)
                }
                "getTodayStats" -> {
                    val stats = getUsageStats(0)
                    result.success(stats)
                }
                "getDetailedStats" -> {
                    val daysAgo = call.argument<Int>("daysAgo") ?: 0
                    val stats = getDetailedStats(daysAgo)
                    result.success(stats)
                }
                "getWeekStats" -> {
                    val stats = getWeekStats()
                    result.success(stats)
                }
                "getUsageWithIcons" -> {
                    val daysAgo = call.argument<Int>("daysAgo") ?: 0
                    val stats = getUsageWithIcons(daysAgo)
                    result.success(stats)
                }
                "getPickups" -> {
                    val daysAgo = call.argument<Int>("daysAgo") ?: 0
                    if (!hasUsageStatsPermission()) {
                        result.success(0)
                    } else {
                        val (startTime, endTime) = getDayRange(daysAgo)
                        val usm = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
                        result.success(countPickups(usm, startTime, endTime))
                    }
                }
                "getAppIcon" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        result.success(getAppIconBytes(packageName))
                    } else {
                        result.error("INVALID_ARG", "packageName required", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun hasUsageStatsPermission(): Boolean {
        val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            appOps.unsafeCheckOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                Process.myUid(),
                packageName
            )
        } else {
            @Suppress("DEPRECATION")
            appOps.checkOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                Process.myUid(),
                packageName
            )
        }
        return mode == AppOpsManager.MODE_ALLOWED
    }

    private fun openUsageAccessSettings() {
        startActivity(Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS))
    }

    // ──────────────────────────────────────────────
    // BASIC STATS (mevcut — geriye uyumlu)
    // ──────────────────────────────────────────────

    private fun getUsageStats(daysAgo: Int): Map<String, Any> {
        if (!hasUsageStatsPermission()) {
            return mapOf("error" to "no_permission", "apps" to emptyList<Any>(), "totalMinutes" to 0)
        }

        val (startTime, endTime) = getDayRange(daysAgo)
        val usm = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        return queryStats(usm, startTime, endTime)
    }

    // ──────────────────────────────────────────────
    // DETAILED STATS (pickups, longest off, categories)
    // ──────────────────────────────────────────────

    private fun getDetailedStats(daysAgo: Int): Map<String, Any> {
        if (!hasUsageStatsPermission()) {
            return mapOf("error" to "no_permission")
        }

        val (startTime, endTime) = getDayRange(daysAgo)
        val usm = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager

        // Basic app usage
        val basicStats = queryStats(usm, startTime, endTime)

        // Phone pickups (screen unlock events)
        val pickups = countPickups(usm, startTime, endTime)

        // Longest offline stretch
        val longestOffMinutes = calculateLongestOff(usm, startTime, endTime)

        // App categories
        val appsWithCategories = addCategories(basicStats["apps"] as List<Map<String, Any>>)

        return basicStats + mapOf(
            "apps" to appsWithCategories,
            "phonePickups" to pickups,
            "longestOffMinutes" to longestOffMinutes
        )
    }

    // ──────────────────────────────────────────────
    // WEEK STATS (son 7 gün — Supabase sync için)
    // ──────────────────────────────────────────────

    private fun getWeekStats(): Map<String, Any> {
        if (!hasUsageStatsPermission()) {
            return mapOf("error" to "no_permission")
        }

        val usm = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val days = mutableListOf<Map<String, Any>>()

        for (i in 0..6) {
            val (startTime, endTime) = getDayRange(i)
            val stats = queryStats(usm, startTime, endTime)
            val pickups = countPickups(usm, startTime, endTime)
            val longestOff = calculateLongestOff(usm, startTime, endTime)

            val cal = Calendar.getInstance()
            cal.add(Calendar.DAY_OF_YEAR, -i)
            val dateStr = String.format(
                "%04d-%02d-%02d",
                cal.get(Calendar.YEAR),
                cal.get(Calendar.MONTH) + 1,
                cal.get(Calendar.DAY_OF_MONTH)
            )

            days.add(
                mapOf(
                    "date" to dateStr,
                    "totalMinutes" to (stats["totalMinutes"] ?: 0),
                    "phonePickups" to pickups,
                    "longestOffMinutes" to longestOff,
                    "apps" to addCategories(stats["apps"] as List<Map<String, Any>>)
                )
            )
        }

        return mapOf("days" to days)
    }

    // ──────────────────────────────────────────────
    // PHONE PICKUPS — UsageEvents ile sayma
    // ──────────────────────────────────────────────

    private fun countPickups(usm: UsageStatsManager, startTime: Long, endTime: Long): Int {
        var pickups = 0
        try {
            val events = usm.queryEvents(startTime, endTime)
            val event = UsageEvents.Event()
            while (events.hasNextEvent()) {
                events.getNextEvent(event)
                // KEYGUARD_HIDDEN = screen unlock (API 28+)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                    if (event.eventType == UsageEvents.Event.KEYGUARD_HIDDEN) {
                        pickups++
                    }
                } else {
                    // Fallback: MOVE_TO_FOREGROUND of launcher
                    @Suppress("DEPRECATION")
                    if (event.eventType == UsageEvents.Event.MOVE_TO_FOREGROUND) {
                        val pn = event.packageName
                        if (isLauncher(pn)) pickups++
                    }
                }
            }
        } catch (_: Exception) {}
        return pickups
    }

    // ──────────────────────────────────────────────
    // LONGEST OFFLINE — Ekransız en uzun süre
    // ──────────────────────────────────────────────

    private fun calculateLongestOff(usm: UsageStatsManager, startTime: Long, endTime: Long): Int {
        val timestamps = mutableListOf<Long>()
        timestamps.add(startTime)

        try {
            val events = usm.queryEvents(startTime, endTime)
            val event = UsageEvents.Event()
            while (events.hasNextEvent()) {
                events.getNextEvent(event)
                if (event.eventType == UsageEvents.Event.ACTIVITY_RESUMED ||
                    event.eventType == UsageEvents.Event.ACTIVITY_PAUSED) {
                    timestamps.add(event.timeStamp)
                }
            }
        } catch (_: Exception) {}

        timestamps.add(minOf(endTime, System.currentTimeMillis()))
        timestamps.sort()

        var longestGap = 0L
        // Gaps between PAUSED and next RESUMED
        for (i in 0 until timestamps.size - 1) {
            val gap = timestamps[i + 1] - timestamps[i]
            if (gap > longestGap) longestGap = gap
        }

        return (longestGap / 60_000).toInt()
    }

    // ──────────────────────────────────────────────
    // APP CATEGORIES — Google Play kategorisi
    // ──────────────────────────────────────────────

    private fun addCategories(apps: List<Map<String, Any>>): List<Map<String, Any>> {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return apps

        val pm = packageManager
        return apps.map { app ->
            val pkgName = app["packageName"] as? String ?: return@map app
            val category = try {
                val appInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    pm.getApplicationInfo(pkgName, PackageManager.ApplicationInfoFlags.of(0))
                } else {
                    @Suppress("DEPRECATION")
                    pm.getApplicationInfo(pkgName, 0)
                }
                categoryToString(appInfo.category)
            } catch (_: Exception) {
                "other"
            }
            app + ("category" to category)
        }
    }

    private fun categoryToString(category: Int): String {
        return when (category) {
            ApplicationInfo.CATEGORY_GAME -> "game"
            ApplicationInfo.CATEGORY_SOCIAL -> "social"
            ApplicationInfo.CATEGORY_VIDEO -> "video"
            ApplicationInfo.CATEGORY_AUDIO -> "audio"
            ApplicationInfo.CATEGORY_IMAGE -> "image"
            ApplicationInfo.CATEGORY_NEWS -> "news"
            ApplicationInfo.CATEGORY_MAPS -> "maps"
            ApplicationInfo.CATEGORY_PRODUCTIVITY -> "productivity"
            ApplicationInfo.CATEGORY_UNDEFINED -> "other"
            else -> "other"
        }
    }

    // ──────────────────────────────────────────────
    // APP ICONS — PackageManager'dan ikon byte[]
    // ──────────────────────────────────────────────

    private fun getUsageWithIcons(daysAgo: Int): Map<String, Any> {
        if (!hasUsageStatsPermission()) {
            return mapOf("error" to "no_permission")
        }

        val (startTime, endTime) = getDayRange(daysAgo)
        val usm = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val basicStats = queryStats(usm, startTime, endTime)
        val pickups = countPickups(usm, startTime, endTime)
        val longestOff = calculateLongestOff(usm, startTime, endTime)

        // Per-app pickups: hangi uygulama telefonu kaç kez ele aldırdı
        val perAppPickups = countPerAppPickups(usm, startTime, endTime)

        val rawApps = basicStats["apps"] as List<Map<String, Any>>
        val appsWithIcons = rawApps.map { app ->
            val pkgName = app["packageName"] as? String ?: return@map app
            val category = try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    val appInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        packageManager.getApplicationInfo(pkgName, PackageManager.ApplicationInfoFlags.of(0))
                    } else {
                        @Suppress("DEPRECATION")
                        packageManager.getApplicationInfo(pkgName, 0)
                    }
                    categoryToString(appInfo.category)
                } else { "other" }
            } catch (_: Exception) { "other" }

            val iconBytes = getAppIconBytes(pkgName)
            val result = app.toMutableMap()
            result["category"] = category
            result["pickups"] = perAppPickups[pkgName] ?: 0
            if (iconBytes != null) {
                result["iconBytes"] = iconBytes
            }
            result.toMap()
        }

        return basicStats + mapOf(
            "apps" to appsWithIcons,
            "phonePickups" to pickups,
            "longestOffMinutes" to longestOff
        )
    }

    // ──────────────────────────────────────────────
    // PER-APP PICKUPS — Hangi uygulama telefonu ele aldırdı
    // ──────────────────────────────────────────────

    /**
     * UsageEvents ile MOVE_TO_FOREGROUND eventlerini sayar.
     * Her uygulama için "kullanıcı bu uygulamayı açmak için telefonu kaç kez eline aldı"
     * bilgisini döner. Kilit açma → ilk açılan uygulama = 1 pickup.
     */
    private fun countPerAppPickups(usm: UsageStatsManager, startTime: Long, endTime: Long): Map<String, Int> {
        val pickupsMap = mutableMapOf<String, Int>()
        try {
            val events = usm.queryEvents(startTime, endTime)
            val event = UsageEvents.Event()
            var lastUnlockTime = 0L
            var firstAppAfterUnlock = true

            while (events.hasNextEvent()) {
                events.getNextEvent(event)

                // Ekran kilidi açıldı
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P &&
                    event.eventType == UsageEvents.Event.KEYGUARD_HIDDEN) {
                    lastUnlockTime = event.timeStamp
                    firstAppAfterUnlock = true
                    continue
                }

                // Uygulama ön plana geldi
                @Suppress("DEPRECATION")
                if (event.eventType == UsageEvents.Event.MOVE_TO_FOREGROUND) {
                    val pkg = event.packageName ?: continue
                    if (isSystemApp(packageManager, pkg) || isLauncher(pkg)) continue

                    // Kilit açıldıktan sonraki ilk uygulama = asıl pickup tetikleyicisi
                    if (firstAppAfterUnlock && lastUnlockTime > 0 &&
                        event.timeStamp - lastUnlockTime < 5000) {
                        pickupsMap[pkg] = (pickupsMap[pkg] ?: 0) + 1
                        firstAppAfterUnlock = false
                    } else {
                        // Genel foreground sayısını da say (app switching)
                        pickupsMap[pkg] = (pickupsMap[pkg] ?: 0) + 1
                    }
                }
            }
        } catch (_: Exception) {}
        return pickupsMap
    }

    /**
     * Verilen packageName'in orijinal uygulama ikonunu PNG byte[] olarak dondurur.
     * Drawable -> Bitmap -> PNG ByteArray.
     * Basarisiz olursa null doner.
     */
    private fun getAppIconBytes(packageName: String): ByteArray? {
        return try {
            val pm = packageManager
            val drawable: Drawable = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                pm.getApplicationIcon(
                    pm.getApplicationInfo(packageName, PackageManager.ApplicationInfoFlags.of(0))
                )
            } else {
                @Suppress("DEPRECATION")
                pm.getApplicationIcon(pm.getApplicationInfo(packageName, 0))
            }

            val bitmap = drawableToBitmap(drawable)
            // 48x48 boyutuna kucult (bellek ve kanal optimizasyonu)
            val scaled = Bitmap.createScaledBitmap(bitmap, 48, 48, true)
            val stream = ByteArrayOutputStream()
            scaled.compress(Bitmap.CompressFormat.PNG, 90, stream)
            if (scaled !== bitmap) scaled.recycle()
            if (bitmap !== (drawable as? BitmapDrawable)?.bitmap) bitmap.recycle()
            stream.toByteArray()
        } catch (_: Exception) {
            null
        }
    }

    private fun drawableToBitmap(drawable: Drawable): Bitmap {
        if (drawable is BitmapDrawable && drawable.bitmap != null) {
            return drawable.bitmap
        }

        val w = if (drawable.intrinsicWidth > 0) drawable.intrinsicWidth else 48
        val h = if (drawable.intrinsicHeight > 0) drawable.intrinsicHeight else 48
        val bitmap = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bitmap
    }

    // ──────────────────────────────────────────────
    // HELPERS
    // ──────────────────────────────────────────────

    private fun getDayRange(daysAgo: Int): Pair<Long, Long> {
        val cal = Calendar.getInstance()
        if (daysAgo == 0) {
            val endTime = cal.timeInMillis
            cal.set(Calendar.HOUR_OF_DAY, 0)
            cal.set(Calendar.MINUTE, 0)
            cal.set(Calendar.SECOND, 0)
            cal.set(Calendar.MILLISECOND, 0)
            return Pair(cal.timeInMillis, endTime)
        } else {
            cal.add(Calendar.DAY_OF_YEAR, -daysAgo)
            cal.set(Calendar.HOUR_OF_DAY, 0)
            cal.set(Calendar.MINUTE, 0)
            cal.set(Calendar.SECOND, 0)
            cal.set(Calendar.MILLISECOND, 0)
            val startTime = cal.timeInMillis
            cal.set(Calendar.HOUR_OF_DAY, 23)
            cal.set(Calendar.MINUTE, 59)
            cal.set(Calendar.SECOND, 59)
            return Pair(startTime, cal.timeInMillis)
        }
    }

    private fun queryStats(usm: UsageStatsManager, startTime: Long, endTime: Long): Map<String, Any> {
        val statsMap = usm.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, startTime, endTime)

        if (statsMap.isNullOrEmpty()) {
            return mapOf("apps" to emptyList<Any>(), "totalMinutes" to 0)
        }

        val pm = packageManager
        val apps = mutableListOf<Map<String, Any>>()
        var totalMs: Long = 0

        for (stat in statsMap) {
            val foregroundMs = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                stat.totalTimeVisible
            } else {
                stat.totalTimeInForeground
            }

            if (foregroundMs < 60_000) continue

            val minutes = (foregroundMs / 60_000).toInt()
            val appName = getAppLabel(pm, stat.packageName)

            if (appName == stat.packageName && isSystemApp(pm, stat.packageName)) continue

            apps.add(
                mapOf(
                    "name" to appName,
                    "packageName" to stat.packageName,
                    "minutes" to minutes
                )
            )
            totalMs += foregroundMs
        }

        val sorted = apps.sortedByDescending { it["minutes"] as Int }
        val totalMinutes = (totalMs / 60_000).toInt()

        return mapOf(
            "apps" to sorted,
            "totalMinutes" to totalMinutes
        )
    }

    private fun getAppLabel(pm: PackageManager, packageName: String): String {
        return try {
            val appInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                pm.getApplicationInfo(packageName, PackageManager.ApplicationInfoFlags.of(0))
            } else {
                @Suppress("DEPRECATION")
                pm.getApplicationInfo(packageName, 0)
            }
            pm.getApplicationLabel(appInfo).toString()
        } catch (e: PackageManager.NameNotFoundException) {
            packageName
        }
    }

    private fun isSystemApp(pm: PackageManager, packageName: String): Boolean {
        return try {
            val appInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                pm.getApplicationInfo(packageName, PackageManager.ApplicationInfoFlags.of(0))
            } else {
                @Suppress("DEPRECATION")
                pm.getApplicationInfo(packageName, 0)
            }
            (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0
        } catch (e: PackageManager.NameNotFoundException) {
            true
        }
    }

    private fun isLauncher(packageName: String): Boolean {
        val intent = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_HOME)
        val resolveInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            packageManager.resolveActivity(intent, PackageManager.ResolveInfoFlags.of(0))
        } else {
            @Suppress("DEPRECATION")
            packageManager.resolveActivity(intent, 0)
        }
        return resolveInfo?.activityInfo?.packageName == packageName
    }
}

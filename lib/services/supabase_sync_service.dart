import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/screen_time_data.dart';
import '../models/story.dart';

/// Supabase ile veri senkronizasyonu.
/// Ekran süresi, profil, stories, badges — hepsi buradan.
class SupabaseSyncService {
  SupabaseSyncService._();
  static final instance = SupabaseSyncService._();

  SupabaseClient get _db => Supabase.instance.client;
  String? get _uid => _db.auth.currentUser?.id;

  // ──────────────────────────────────────────────
  // SCREEN TIME SYNC
  // ──────────────────────────────────────────────

  /// Günlük ekran süresini Supabase'e yazar (upsert).
  Future<void> syncDailyScreenTime(ScreenTimeData data) async {
    if (_uid == null) return;
    final dateStr = _dateStr(data.date);

    try {
      // Ana tablo: screen_time_daily
      await _db.from('screen_time_daily').upsert({
        'user_id': _uid,
        'date': dateStr,
        'total_minutes': data.totalMinutes,
        'phone_pickups': data.phoneOpens,
        'longest_off_minutes': data.longestOffScreenMinutes,
        'goal_minutes': data.goalMinutes,
      }, onConflict: 'user_id,date');

      // App usage detayları
      for (final app in data.apps) {
        await _db.from('app_usage').upsert({
          'user_id': _uid,
          'date': dateStr,
          'package_name': app.packageName,
          'app_name': app.name,
          'minutes': app.minutes,
          'category': app.category,
        }, onConflict: 'user_id,date,package_name');
      }
    } catch (e) {
      debugPrint('syncDailyScreenTime error: $e');
    }
  }

  /// Son 7 günü toplu sync.
  Future<void> syncWeekData(List<ScreenTimeData> days) async {
    for (final day in days) {
      await syncDailyScreenTime(day);
    }
  }

  // ──────────────────────────────────────────────
  // PROFILE
  // ──────────────────────────────────────────────

  /// Profil güncelle (display_name, avatar, city, vb.)
  Future<void> updateProfile(Map<String, dynamic> fields) async {
    if (_uid == null) return;
    await _db.from('profiles').update({
      ...fields,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', _uid!);
  }

  /// Profil bilgilerini çek
  Future<Map<String, dynamic>?> getProfile() async {
    if (_uid == null) return null;
    final res = await _db.from('profiles').select().eq('id', _uid!).maybeSingle();
    return res;
  }

  /// Onboarding tamamlandı işaretle
  Future<void> completeOnboarding({
    required String displayName,
    required String city,
    required String country,
    required int birthYear,
    required int dailyGoalMinutes,
  }) async {
    await updateProfile({
      'display_name': displayName,
      'city': city,
      'country': country,
      'birth_year': birthYear,
      'daily_goal_minutes': dailyGoalMinutes,
      'onboarded': true,
    });
  }

  // ──────────────────────────────────────────────
  // AVATAR UPLOAD
  // ──────────────────────────────────────────────

  /// Profil fotoğrafı yükle, URL'yi profile yaz.
  Future<String?> uploadAvatar(List<int> bytes, String extension) async {
    if (_uid == null) return null;
    final path = '$_uid/avatar.$extension';

    try {
      await _db.storage.from('avatars').uploadBinary(
            path,
            bytes as dynamic,
            fileOptions: const FileOptions(upsert: true),
          );

      final url = _db.storage.from('avatars').getPublicUrl(path);
      await updateProfile({'avatar_url': url});
      return url;
    } catch (e) {
      debugPrint('uploadAvatar error: $e');
      return null;
    }
  }

  // ──────────────────────────────────────────────
  // STORIES
  // ──────────────────────────────────────────────

  /// Arkadaşların aktif story'lerini çek (expire olmamış).
  Future<List<Story>> getFriendStories() async {
    if (_uid == null) return [];
    try {
      final res = await _db
          .from('anti_social_posts')
          .select('*, profiles!inner(display_name, avatar_url, avatar_color)')
          .gt('expires_at', DateTime.now().toIso8601String())
          .order('created_at', ascending: false)
          .limit(50);

      return (res as List).map((e) => Story.fromJson(e)).toList();
    } catch (e) {
      debugPrint('getFriendStories error: $e');
      return [];
    }
  }

  /// Kendi story'lerimi çek.
  Future<List<Story>> getMyStories() async {
    if (_uid == null) return [];
    try {
      final res = await _db
          .from('anti_social_posts')
          .select('*, profiles(display_name, avatar_url, avatar_color)')
          .eq('user_id', _uid!)
          .order('created_at', ascending: false)
          .limit(20);

      return (res as List).map((e) => Story.fromJson(e)).toList();
    } catch (e) {
      debugPrint('getMyStories error: $e');
      return [];
    }
  }

  /// Yeni story paylaş.
  Future<Story?> createStory({
    required String? caption,
    String? activityType,
    String visibility = 'friends',
    String storyType = 'photo',
    int durationHours = 24,
    List<int>? imageBytes,
    String? imageExtension,
  }) async {
    if (_uid == null) return null;

    String? imageUrl;
    if (imageBytes != null && imageExtension != null) {
      imageUrl = await _uploadStoryImage(imageBytes, imageExtension);
    }

    try {
      final res = await _db.from('anti_social_posts').insert({
        'user_id': _uid,
        'date': _dateStr(DateTime.now()),
        'caption': caption,
        'activity_type': activityType,
        'image_url': imageUrl,
        'visibility': visibility,
        'story_type': storyType,
        'duration_hours': durationHours,
      }).select('*, profiles(display_name, avatar_url, avatar_color)').single();

      return Story.fromJson(res);
    } catch (e) {
      debugPrint('createStory error: $e');
      return null;
    }
  }

  /// Story sil.
  Future<void> deleteStory(String storyId) async {
    await _db.from('anti_social_posts').delete().eq('id', storyId);
  }

  /// Story görüntüleme kaydet.
  Future<void> markStoryViewed(String storyId) async {
    if (_uid == null) return;
    try {
      await _db.from('story_views').upsert({
        'story_id': storyId,
        'viewer_id': _uid,
      }, onConflict: 'story_id,viewer_id');

      // view_count artır
      await _db.rpc('increment_story_view_count', params: {'p_story_id': storyId});
    } catch (_) {}
  }

  Future<String?> _uploadStoryImage(List<int> bytes, String extension) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '$_uid/$timestamp.$extension';

    try {
      await _db.storage.from('stories').uploadBinary(
            path,
            bytes as dynamic,
            fileOptions: const FileOptions(upsert: true),
          );
      return _db.storage.from('stories').getPublicUrl(path);
    } catch (e) {
      debugPrint('_uploadStoryImage error: $e');
      return null;
    }
  }

  // ──────────────────────────────────────────────
  // RANKINGS
  // ──────────────────────────────────────────────

  /// Haftalık ranking'leri çek.
  Future<List<Map<String, dynamic>>> getRankings({
    String? city,
    String? country,
    int limit = 50,
  }) async {
    try {
      var query = _db.from('weekly_rankings').select();
      if (city != null) query = query.eq('city', city);
      if (country != null) query = query.eq('country', country);

      final res = await query.order('global_rank').limit(limit);
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      debugPrint('getRankings error: $e');
      return [];
    }
  }

  // ──────────────────────────────────────────────
  // FRIENDSHIPS
  // ──────────────────────────────────────────────

  /// Arkadaşlık isteği gönder.
  Future<void> sendFriendRequest(String addresseeId) async {
    if (_uid == null) return;
    await _db.from('friendships').insert({
      'requester_id': _uid,
      'addressee_id': addresseeId,
    });
  }

  /// Arkadaşlık isteği kabul et.
  Future<void> acceptFriendRequest(String friendshipId) async {
    await _db
        .from('friendships')
        .update({'status': 'accepted'}).eq('id', friendshipId);
  }

  /// Arkadaş listesini çek.
  Future<List<Map<String, dynamic>>> getFriends() async {
    if (_uid == null) return [];
    try {
      final res = await _db
          .from('friendships')
          .select('*, requester:profiles!requester_id(*), addressee:profiles!addressee_id(*)')
          .eq('status', 'accepted')
          .or('requester_id.eq.$_uid,addressee_id.eq.$_uid');
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      debugPrint('getFriends error: $e');
      return [];
    }
  }

  /// Friend code ile arkadaş bul.
  Future<Map<String, dynamic>?> findByFriendCode(String code) async {
    final res = await _db
        .from('profiles')
        .select()
        .eq('friend_code', code.toUpperCase())
        .maybeSingle();
    return res;
  }

  // ──────────────────────────────────────────────
  // DEVICES (FCM Token)
  // ──────────────────────────────────────────────

  /// FCM token kaydet/güncelle.
  Future<void> registerDevice({
    required String fcmToken,
    required String platform,
  }) async {
    if (_uid == null) return;
    await _db.from('devices').upsert({
      'user_id': _uid,
      'fcm_token': fcmToken,
      'platform': platform,
      'is_active': true,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'user_id,fcm_token');
  }

  // ──────────────────────────────────────────────
  // REPORT CARDS
  // ──────────────────────────────────────────────

  /// Son rapor kartlarını çek.
  Future<List<Map<String, dynamic>>> getReportCards({int limit = 10}) async {
    if (_uid == null) return [];
    final res = await _db
        .from('report_cards')
        .select()
        .eq('user_id', _uid!)
        .order('week_start', ascending: false)
        .limit(limit);
    return List<Map<String, dynamic>>.from(res);
  }

  // ──────────────────────────────────────────────
  // ACCOUNT DELETION
  // ──────────────────────────────────────────────

  /// Hesabı tamamen sil (cascade delete ile tüm veriler gider).
  Future<void> deleteAccount() async {
    if (_uid == null) return;
    // Supabase Edge Function çağır (auth.users silme yetkisi gerekli)
    await _db.functions.invoke('delete-account');
  }

  // ──────────────────────────────────────────────
  // HELPERS
  // ──────────────────────────────────────────────

  String _dateStr(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

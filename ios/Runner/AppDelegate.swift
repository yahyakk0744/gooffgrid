import Flutter
import UIKit
import FamilyControls
import DeviceActivity

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {

  private let appGroupId = "group.com.gooffgrid.shared"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(
        name: "com.gooffgrid/screen_time",
        binaryMessenger: controller.binaryMessenger
      )
      channel.setMethodCallHandler { [weak self] (call, result) in
        self?.handleMethodCall(call: call, result: result)
      }

      // Register iOS Platform View for DeviceActivityReport (native app icons)
      if #available(iOS 16.0, *) {
        let factory = ScreenTimeReportViewFactory(messenger: controller.binaryMessenger)
        let registrar = controller.registrar(forPlugin: "ScreenTimeReportView")
        registrar?.register(factory, withId: "com.gooffgrid/screen_time_report")
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {

    case "hasPermission":
      if #available(iOS 16.0, *) {
        let status = AuthorizationCenter.shared.authorizationStatus
        result(status == .approved)
      } else {
        result(false)
      }

    case "requestPermission":
      if #available(iOS 16.0, *) {
        Task {
          do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            // Izin verildikten sonra DeviceActivity monitor'u baslat
            self.startMonitoring()
            result(true)
          } catch {
            result(FlutterError(
              code: "AUTH_FAILED",
              message: "Screen Time authorization failed: \(error.localizedDescription)",
              details: nil
            ))
          }
        }
      } else {
        result(FlutterError(
          code: "UNSUPPORTED",
          message: "Screen Time API requires iOS 16+",
          details: nil
        ))
      }

    case "getUsageStats", "getTodayStats":
      // App Group shared storage'dan DeviceActivityReport'un yazdigi veriyi oku
      let data = readScreenTimeFromAppGroup()
      result(data)

    case "startMonitoring":
      if #available(iOS 16.0, *) {
        startMonitoring()
        result(nil)
      } else {
        result(nil)
      }

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  /// App Group'tan screen time verisini okur
  private func readScreenTimeFromAppGroup() -> [String: Any] {
    guard let defaults = UserDefaults(suiteName: appGroupId),
          let jsonString = defaults.string(forKey: "screenTimeData"),
          let jsonData = jsonString.data(using: .utf8),
          let data = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
    else {
      return [
        "apps": [] as [[String: Any]],
        "totalMinutes": 0
      ]
    }

    // apps dizisindeki bundleId'yi packageName'e donustur (Flutter uyumlulugu)
    if var apps = data["apps"] as? [[String: Any]] {
      apps = apps.map { app in
        var mapped = app
        if let bundleId = app["bundleId"] as? String {
          mapped["packageName"] = bundleId
        }
        if let totalSeconds = app["totalSeconds"] as? Int {
          mapped["minutes"] = totalSeconds / 60
        }
        return mapped
      }
      var result = data
      result["apps"] = apps
      return result
    }

    return data
  }

  /// DeviceActivity monitoring'i baslatir
  @available(iOS 16.0, *)
  private func startMonitoring() {
    let center = DeviceActivityCenter()

    // Bugunun baslangicindan gece yarisina kadar monitor et
    let calendar = Calendar.current
    let now = Date()
    let startOfDay = calendar.startOfDay(for: now)

    let startComponents = calendar.dateComponents(
      [.hour, .minute, .second],
      from: startOfDay
    )
    let endComponents = DateComponents(hour: 23, minute: 59, second: 59)

    let schedule = DeviceActivitySchedule(
      intervalStart: startComponents,
      intervalEnd: endComponents,
      repeats: true
    )

    do {
      try center.startMonitoring(
        DeviceActivityName("dailyActivity"),
        during: schedule
      )
    } catch {
      print("Failed to start monitoring: \(error)")
    }
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}

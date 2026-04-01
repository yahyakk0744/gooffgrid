import DeviceActivity
import SwiftUI

@available(iOS 16.0, *)
class ScreenTimeReportExtension: DeviceActivityReportExtension {

    override func content(
        configuration: DeviceActivityReport<ScreenTimeReportExtension>.Configuration
    ) -> some DeviceActivityReportScene {
        TotalActivityReport()
    }
}

/// Gunluk toplam kullanim raporu
@available(iOS 16.0, *)
struct TotalActivityReport: DeviceActivityReportScene {

    let context: DeviceActivityReport.Context = .init(rawValue: "totalActivity")

    let content: (ActivityReport) -> TotalActivityView

    init() {
        self.content = { report in
            TotalActivityView(report: report)
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        // Apple bu metodu kullanim verisiyle cagiriyor
        // Veriyi parse edip App Group'a yaziyoruz
        let apps = configuration.totalActivity.map { activity -> [String: Any] in
            return [
                "bundleId": activity.application.bundleIdentifier ?? "unknown",
                "name": activity.application.localizedDisplayName ?? "Unknown",
                "totalSeconds": Int(activity.totalActivityDuration)
            ]
        }

        let totalSeconds = configuration.totalActivity.reduce(0) { sum, activity in
            sum + Int(activity.totalActivityDuration)
        }

        // App Group shared storage'a yaz
        let data: [String: Any] = [
            "apps": apps,
            "totalMinutes": totalSeconds / 60,
            "timestamp": ISO8601DateFormatter().string(from: Date())
        ]

        if let jsonData = try? JSONSerialization.data(withJSONObject: data),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            let defaults = UserDefaults(suiteName: "group.com.gooffgrid.shared")
            defaults?.set(jsonString, forKey: "screenTimeData")
            defaults?.synchronize()
        }

        return content(ActivityReport(
            totalMinutes: totalSeconds / 60,
            apps: apps.map { dict in
                AppUsage(
                    name: dict["name"] as? String ?? "Unknown",
                    bundleId: dict["bundleId"] as? String ?? "unknown",
                    minutes: (dict["totalSeconds"] as? Int ?? 0) / 60
                )
            }
        ))
    }
}

// MARK: - Data Models

struct ActivityReport {
    let totalMinutes: Int
    let apps: [AppUsage]
}

struct AppUsage: Identifiable {
    let id = UUID()
    let name: String
    let bundleId: String
    let minutes: Int
}

// MARK: - SwiftUI View (minimal — sadece veri aktarimi icin)

@available(iOS 16.0, *)
struct TotalActivityView: View {
    let report: ActivityReport

    var body: some View {
        // Bu view gorunmez — sadece veri aktarimi icin
        Color.clear
            .frame(width: 1, height: 1)
    }
}

import Flutter
import UIKit
import SwiftUI
import DeviceActivity
import FamilyControls

/// FlutterPlatformViewFactory: Apple'ın DeviceActivityReport'unu
/// Flutter widget ağacına gömer. Apple sandboxing kuralları gereği
/// ham ikon byte[] çekilemez — bu native view OS'un kendi UI'ı ile
/// orijinal app ikonlarını ve kullanım barlarını render eder.
@available(iOS 16.0, *)
class ScreenTimeReportViewFactory: NSObject, FlutterPlatformViewFactory {
  private let messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    return ScreenTimeReportPlatformView(
      frame: frame,
      viewIdentifier: viewId,
      arguments: args,
      messenger: messenger
    )
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    return FlutterStandardMessageCodec.sharedInstance()
  }
}

@available(iOS 16.0, *)
class ScreenTimeReportPlatformView: NSObject, FlutterPlatformView {
  private var hostingController: UIHostingController<AnyView>?
  private let containerView: UIView

  init(
    frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?,
    messenger: FlutterBinaryMessenger
  ) {
    containerView = UIView(frame: frame)
    containerView.backgroundColor = .clear
    super.init()

    let argsDict = args as? [String: Any]
    let daysAgo = argsDict?["daysAgo"] as? Int ?? 0
    let reportHeight = argsDict?["height"] as? Double ?? 400.0

    let calendar = Calendar.current
    let now = Date()
    let targetDate = calendar.date(byAdding: .day, value: -daysAgo, to: now) ?? now
    let startOfDay = calendar.startOfDay(for: targetDate)
    let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? now

    let filter = DeviceActivityFilter(
      segment: .daily(
        during: DateInterval(start: startOfDay, end: endOfDay)
      )
    )

    let reportView = ScreenTimeReportSwiftUIView(
      filter: filter,
      height: reportHeight
    )
    let hosting = UIHostingController(rootView: AnyView(reportView))
    hosting.view.backgroundColor = .clear
    hosting.view.frame = containerView.bounds
    hosting.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    containerView.addSubview(hosting.view)
    hostingController = hosting
  }

  func view() -> UIView {
    return containerView
  }
}

/// SwiftUI wrapper: DeviceActivityReport'u dark tema ve neon vurgularla render eder.
/// Apple'ın kendi report view'ı uygulamaların orijinal ikonlarını gösterir.
@available(iOS 16.0, *)
struct ScreenTimeReportSwiftUIView: View {
  let filter: DeviceActivityFilter
  let height: Double

  var body: some View {
    ZStack {
      // Glassmorphism benzeri koyu zemin
      RoundedRectangle(cornerRadius: 16)
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [
              Color(red: 0.11, green: 0.11, blue: 0.18),
              Color(red: 0.10, green: 0.10, blue: 0.10)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .strokeBorder(
              Color.white.opacity(0.08),
              lineWidth: 1
            )
        )

      // Apple'ın native DeviceActivityReport view'ı
      DeviceActivityReport(
        DeviceActivityReport.Context(
          rawValue: "TotalActivity"
        ),
        filter: filter
      )
      .padding(12)
    }
    .frame(height: height)
    .preferredColorScheme(.dark)
  }
}

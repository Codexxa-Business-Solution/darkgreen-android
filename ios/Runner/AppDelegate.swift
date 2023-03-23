import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideApiKey("AIzaSyDmGf486wAvt_8sDkl7i7qE2RRwGIB5qmk")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

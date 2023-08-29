import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller : FlutterViewController = window?rootViewController as! FlutterViewController
    let keychainChannel = FlutterMethodChannel(name:"brightnessPlatform",binaryMessenger: controller.binaryMessenger)

    keychainChannel.setMethodCallHandler({
      (call:FlutterMethodCall, result: @escaping FlutterResult) -> Void in

      if call.method == "setBrightness" {
          if let args = call.arguments as? Dictionary<String,Any>, let data = args["brightness"] as? Double {
            self.window.windowScene?.screen.brightness = CGFloat(data)
          } else {
            result(FlutterError.init(code : "errorSetDebug",message:  "data or format error", details: nil))
          }
      } else if call.method == "getBrightness" {
          result("\(self.window!.windowScene!.screen.brightness)")
      } else {
          result(FlutterMethodNotImplemented)
          return
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

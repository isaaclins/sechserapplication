import Flutter
import UIKit
import IOKit.ps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let platformChannel = FlutterMethodChannel(name: "com.example.sechserapplication/platform",
                                             binaryMessenger: controller.binaryMessenger)
    
    platformChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
      case "getBatteryLevel":
        let level = self.getBatteryLevel()
        result(level)
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func getBatteryLevel() -> Int {
    let service = IOServiceGetMatchingService(kIOMasterPortDefault,
                                            IOServiceMatching("AppleSmartBattery"))
    defer { IOObjectRelease(service) }
    
    var props: Unmanaged<CFMutableDictionary>?
    let status = IORegistryEntryCreateCFProperties(service, &props, kCFAllocatorDefault, 0)
    guard status == KERN_SUCCESS, let dict = props?.takeRetainedValue() as? [String: Any] else {
      return -1
    }
    
    let level = dict["CurrentCapacity"] as? Int ?? -1
    let capacity = dict["MaxCapacity"] as? Int ?? -1
    
    if level >= 0 && capacity > 0 {
      return Int((Float(level) / Float(capacity)) * 100)
    }
    
    return -1
  }
}

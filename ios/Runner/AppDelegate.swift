import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    //注册通道
    let rootVc : FlutterViewController = window.rootViewController as! FlutterViewController
    let barreryChannel = FlutterMethodChannel.init(name: "channel.com.example/battery", binaryMessenger: rootVc as! FlutterBinaryMessenger);
    
    //处理函数
    barreryChannel.setMethodCallHandler { (call: FlutterMethodCall, result: FlutterResult) in
        switch call.method {
            case "getBatteryLevel":
                self.receiveBatteryLevel(result: result);
        default:
            result(FlutterMethodNotImplemented);
        }
        
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    private func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current;
      device.isBatteryMonitoringEnabled = true;
        if (device.batteryState == UIDevice.BatteryState.unknown) {
        result(FlutterError.init(code: "UNAVAILABLE",
                                 message: "Battery info unavailable",
                                 details: nil));
      } else {
        result(Int(device.batteryLevel * 100));
      }
    }
    
}

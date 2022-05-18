import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "flutter_app_shortcut", binaryMessenger: controller.binaryMessenger)
      
      channel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        
        if (call.method == nil) {
            return
        }
        
        switch call.method {
        case "getAllShortcuts":
            self?.getAllShortcuts(result: result)
        case "disableShortcuts":
            result(FlutterMethodNotImplemented)
        case "enableShortcuts":
            result(FlutterMethodNotImplemented)
        case "setShortcuts":
            self?.setShortcuts(result: result)
        case "pushShortcut":
            result(FlutterMethodNotImplemented)
        case "removeShortcut":
            result(FlutterMethodNotImplemented)
        case "removeAllShortcuts":
            result(FlutterMethodNotImplemented)
        default:
            result(FlutterMethodNotImplemented)
        }
    })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func getAllShortcuts(result: FlutterResult) {
        result(FlutterMethodNotImplemented)
    }
    
    private func setShortcuts(result: FlutterResult) {
        let searchItem = UIApplicationShortcutItem(type: "a",
                                                   localizedTitle: "Title",
                                                   localizedSubtitle: "Sub title",
                                                   icon: UIApplicationShortcutIcon(type: .update),
                                                   userInfo: nil)
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
        shortcutItems.append(searchItem)
        UIApplication.shared.shortcutItems = shortcutItems
        result(true)
    }
}

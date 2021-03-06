import Flutter
import UIKit

struct ShortcutArg {
    var id: String
    var title: String
    var subtitle: String
    var icon: String
    var flutterIcon: String

    init(dict: Dictionary<String, Any>) {
        self.id = dict["id"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.icon = dict["iconResourceName"] as? String ?? ""
        self.flutterIcon = dict["flutterIconPath"] as? String ?? ""
        // Set subtitle
        var subtitle: String = ""
        if let iosArg = dict["iosArg"] as? [String: Any] {
            subtitle = iosArg["subtitle"] as? String ?? ""
        }
        self.subtitle = subtitle
    }
}


public class SwiftFlutterAppShortcutPlugin: NSObject, FlutterPlugin {
  var localRegistrar: FlutterPluginRegistrar?

  init(registrar: FlutterPluginRegistrar) {
     self.localRegistrar = registrar
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_app_shortcut", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAppShortcutPlugin(registrar: registrar)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getAllShortcuts":
        self.getAllShortcuts(call: call, result: result)
    case "setShortcuts":
        self.setShortcuts(call: call, result: result)
    case "removeAllShortcuts":
        self.removeAllShortcuts(call: call, result: result)
    case "pushShortcut":
        self.pushShortcut(call: call, result: result)
    case "removeShortcut":
        self.removeShortcut(call: call, result: result)
    default:
        result(FlutterMethodNotImplemented)
    }
  }

  private func pushShortcut(call: FlutterMethodCall, result: FlutterResult) {
     var shortcuts = UIApplication.shared.shortcutItems ?? []
     if let args = call.arguments as? Dictionary<String, Any> {
       let shortcutArg = ShortcutArg(dict: args)
       shortcuts.append(
         UIApplicationShortcutItem(
           type: shortcutArg.id,
           localizedTitle: shortcutArg.title,
           localizedSubtitle: shortcutArg.subtitle,
           icon: UIApplicationShortcutIcon(
             templateImageName: shortcutArg.icon
           )
         )
       )
       UIApplication.shared.shortcutItems = shortcuts
       result(true)
     } else {
       result(FlutterError.init(code: "bad args", message: nil, details: nil))
     }
   }

  private func removeShortcut(call: FlutterMethodCall, result: FlutterResult) {
    var shortcutItems = UIApplication.shared.shortcutItems ?? []

    guard let args = call.arguments as? Dictionary<String, Any>  else {
      result(FlutterError.init(code: "bad args", message: nil, details: nil))
      return
    }
    for (index, item) in shortcutItems.enumerated() {
      if item.type == (args["id"] as! String) {
        shortcutItems.remove(at: index)
      }
    }
    UIApplication.shared.shortcutItems = shortcutItems
    result(true)
  }

  private func getAllShortcuts(call: FlutterMethodCall, result: FlutterResult) {
      let shortcutItems = UIApplication.shared.shortcutItems ?? []
      var resultDict = [String: Any]()
      for (_, item) in shortcutItems.enumerated() {
        resultDict[item.type] = [
          "id": item.type,
          "title": item.localizedTitle,
          "iosArg": [
            "subtitle": item.localizedSubtitle
          ]
        ]
      }

      result(resultDict)
  }

  private func setShortcuts(call: FlutterMethodCall, result: FlutterResult) {
    var shortcutArgs: [ShortcutArg] = []
    if let args = call.arguments as? Dictionary<String, Any> {
      for (_, value) in args {
        let itemDict = value as! Dictionary<String, Any>
        shortcutArgs.append(ShortcutArg(dict: itemDict))
      }
    } else {
      result(FlutterError.init(code: "bad args", message: nil, details: nil))
    }

    var shortcutItems: [UIApplicationShortcutItem] = []
    for shortcutArg in shortcutArgs {
      shortcutItems.append(
        UIApplicationShortcutItem(
        type: shortcutArg.id,
        localizedTitle: shortcutArg.title,
        localizedSubtitle: shortcutArg.subtitle,
        icon: UIApplicationShortcutIcon(
          templateImageName: shortcutArg.icon)
        )
      )
    }
    UIApplication.shared.shortcutItems = shortcutItems
    result(true)
  }

  private func removeAllShortcuts(call: FlutterMethodCall, result: FlutterResult) {
      UIApplication.shared.shortcutItems = []
      result(true)
  }
}


#import "FlutterAppShortcutPlugin.h"
#if __has_include(<flutter_app_shortcut/flutter_app_shortcut-Swift.h>)
#import <flutter_app_shortcut/flutter_app_shortcut-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_app_shortcut-Swift.h"
#endif

@implementation FlutterAppShortcutPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAppShortcutPlugin registerWithRegistrar:registrar];
}
@end

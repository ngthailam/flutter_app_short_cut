import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_app_shortcut/short_cut_arg.dart';

abstract class FlutterAppShortcutFunctions {
  Future set(List<ShortcutArg> shortCuts);

  Future push(ShortcutArg shortcut);

  Future removeById(String shortcutId);

  Future removeAll();

  Future enableShortcuts(List<String> shortcutIds);

  Future disableShortcuts(List<String> shortcutIds);
}

/// Android:
/// Read more here: https://developer.android.com/guide/topics/ui/shortcuts
/// This only controls dynamic app shortcuts
///
/// IOS: TBD
class FlutterAppShortcut implements FlutterAppShortcutFunctions {
  static const MethodChannel _channel = MethodChannel('flutter_app_shortcut');

  @override
  Future<dynamic> set(List<ShortcutArg> shortCuts) async {
    final Map arguments = {};
    for (var element in shortCuts) {
      arguments[element.id] = element.toMap();
    }
    return _channel.invokeMethod('setShortcuts', arguments);
  }

  @override
  Future push(ShortcutArg shortcut) {
    final arguments = shortcut.toMap();
    return _channel.invokeMethod('pushShortcut', arguments);
  }

  @override
  Future removeAll() {
    return _channel.invokeMethod('removeAllShortcuts');
  }

  @override
  Future removeById(String shortcutId) {
    final arguments = {
      'id': shortcutId,
    };
    return _channel.invokeMethod('removeShortcut', arguments);
  }

  @override
  Future disableShortcuts(List<String> shortcutIds) {
    final arguments = {for (var id in shortcutIds) id: id};
    return _channel.invokeMethod('disableShortcuts', arguments);
  }

  @override
  Future enableShortcuts(List<String> shortcutIds) {
    final arguments = {for (var id in shortcutIds) id: id};
    return _channel.invokeMethod('enableShortcuts', arguments);
  }
}

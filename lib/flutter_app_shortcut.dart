import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_app_shortcut/short_cut_arg.dart';

abstract class FlutterAppShortcutFunctions {
  Future<List<ShortcutArg>> getAll();

  Future set(List<ShortcutArg> shortCuts);

  Future push(ShortcutArg shortcut);

  Future removeById(String shortcutId);

  Future removeAll();

  Future enableShortcuts(List<String> shortcutIds);

  Future disableShortcuts(List<DisableShortcutArg> disableArgs);
}

/// Android:
/// Read more here: https://developer.android.com/guide/topics/ui/shortcuts
/// This only controls dynamic app shortcuts
///
/// IOS: TBD
class FlutterAppShortcut implements FlutterAppShortcutFunctions {
  static const MethodChannel _channel = MethodChannel('flutter_app_shortcut');

  @override
  Future<List<ShortcutArg>> getAll() async {
    final data = await _channel.invokeMethod('getAllShortcuts');
    final result = <ShortcutArg>[];

    data.forEach((key, value) {
      result.add(ShortcutArg.fromMap(value));
    });

    return result;
  }

  @override
  Future set(List<ShortcutArg> shortCuts) async {
    if (shortCuts.isEmpty) return Future.value(true);
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
    if (shortcutId.isEmpty) return Future.value(true);
    final arguments = {
      'id': shortcutId,
    };
    return _channel.invokeMethod('removeShortcut', arguments);
  }

  @override
  Future disableShortcuts(List<DisableShortcutArg> disableArgs) {
    if (disableArgs.isEmpty) return Future.value(true);
    final arguments = {for (var arg in disableArgs) arg.id: arg.reason};
    return _channel.invokeMethod('disableShortcuts', arguments);
  }

  @override
  Future enableShortcuts(List<String> shortcutIds) {
    if (shortcutIds.isEmpty) return Future.value(true);
    final arguments = {for (var id in shortcutIds) id: id};
    return _channel.invokeMethod('enableShortcuts', arguments);
  }
}

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_app_shortcut/short_cut_arg.dart';

abstract class FlutterAppShortcutFunctions {
  /// Supported platform: Android, IOS
  /// Get all current short cuts
  ///
  /// Does not return iconResourceName due to platform limitations
  /// Android: Does not include disabled shortcuts that is not pinned
  ///
  /// @returns List<ShortcutArg>
  Future<List<ShortcutArg>> getAll();

  /// Supported platform: Android, IOS
  /// Set app shortcuts
  /// Will delete all current shortcuts and set new ones
  ///
  /// @param shortCuts: List of shortcuts to set
  ///
  /// @returns true if success
  ///          error if fail
  Future set(List<ShortcutArg> shortcuts);

  /// Supported platform: Android, IOS
  /// Push a new shortcut
  /// Will update old shortcut if `id` is identical
  /// If there is already 4 shortcuts, 1 shortcut will be removed
  ///
  /// @param shortcut: shortcut to push
  ///
  /// @returns true if success
  ///          error if fail
  Future push(ShortcutArg shortcut);

  /// Supported platform: Android, IOS
  /// Remove shortcut by id
  ///
  /// @param shortcutId: id of shortcut to remove
  ///
  /// @returns true if success
  ///          error if fail
  Future removeById(String shortcutId);

  /// Supported platform: Android, IOS
  /// Remove all current shortcuts
  ///
  /// @returns true if success
  ///          error if fail
  Future removeAll();

  /// Supported platform: Android
  /// Enable shortcut by ids
  /// Already enabled shortcuts will not change
  ///
  /// @param shortcutIds: List of shortcut ids to enable
  ///
  /// @returns true if success
  ///          error if fail
  Future enableShortcuts(List<String> shortcutIds);

  /// Supported platform: Android
  /// Disable shortcuts by ids
  ///
  /// @param disableArgs: Args to disable shortcuts
  ///
  /// @returns true if success
  ///          error if fail
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

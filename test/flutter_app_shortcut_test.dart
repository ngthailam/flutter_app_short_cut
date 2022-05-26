import 'package:flutter/services.dart';
import 'package:flutter_app_shortcut/flutter_app_shortcut.dart';
import 'package:flutter_app_shortcut/short_cut_arg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_app_shortcut');

  TestWidgetsFlutterBinding.ensureInitialized();

  ShortcutArg shortcut1 = ShortcutArg(id: 'id_1', title: 'title_1');
  ShortcutArg shortcut2 = ShortcutArg(
    id: 'id_2',
    title: 'title_2',
    iosArg: const IosArg(subtitle: 'subtitle'),
  );

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getAllShortcuts':
          return {
            'id_1': shortcut1.toMap(),
            'id_2': shortcut2.toMap(),
          };
        case 'setShortcuts':
          return true;
        case 'pushShortcut':
          return true;
        case 'removeAllShortcuts':
          return true;
        case 'removeShortcut':
          return true;
        case 'disableShortcuts':
          return true;
        case 'enableShortcuts':
          return true;
        default:
          return '';
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('test FlutterAppShortcut.getAll', () async {
    final actual = await FlutterAppShortcut().getAll();
    final expected = [shortcut1, shortcut2];

    expect(actual.length, expected.length);
    for (var i = 0; i < actual.length; i++) {
      expect(actual[i].toMap(), expected[i].toMap());
    }
  });

  test('test FlutterAppShortcut.setShortcuts', () async {
    final actual = await FlutterAppShortcut().set([shortcut1, shortcut2]);
    const expected = true;

    expect(actual, expected);
  });

  test('test FlutterAppShortcut.push', () async {
    final actual = await FlutterAppShortcut().push(shortcut1);
    const expected = true;

    expect(actual, expected);
  });

  test('test FlutterAppShortcut.removeAll', () async {
    final actual = await FlutterAppShortcut().removeAll();
    const expected = true;

    expect(actual, expected);
  });

  test('test FlutterAppShortcut.removeById', () async {
    final actual = await FlutterAppShortcut().removeById(shortcut1.id);
    const expected = true;

    expect(actual, expected);
  });

  test('test FlutterAppShortcut.disableShortcuts', () async {
    final actual = await FlutterAppShortcut().disableShortcuts(
      [const DisableShortcutArg(id: 'id_1')],
    );
    const expected = true;

    expect(actual, expected);
  });

  test('test FlutterAppShortcut.enableShortcuts', () async {
    final actual = await FlutterAppShortcut().enableShortcuts([
      shortcut1.id,
    ]);
    const expected = true;

    expect(actual, expected);
  });
}

import 'package:flutter_app_shortcut/short_cut_arg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Set up
  });

  tearDown(() {
    // Tear down
  });

  ///
  /// Test IosArg
  ///
  group('test IosArg', () {
    const String subtitle = "short cut subtite";

    test('test IosArg default constructor', () {
      expect(const IosArg().subtitle, '');
    });
    test('test IosArg toMap', () {
      final expected = {
        "subtitle": subtitle,
      };
      expect(const IosArg(subtitle: subtitle).toMap(), expected);
    });

    test('test IosArg fromMap valid data', () {
      const expected = IosArg(subtitle: subtitle);
      final inputMap = {"subtitle": subtitle};

      expect(IosArg.fromMap(inputMap).subtitle, expected.subtitle);
    });

    test('test IosArg fromMap null data', () {
      final inputMap = {"subtitle": null};

      expect(IosArg.fromMap(inputMap).subtitle, '');
    });

    test('test IosArg copyWith', () {
      const expected = IosArg(subtitle: subtitle);
      final actual = const IosArg().copyWith(subtitle: subtitle);

      expect(actual.subtitle, expected.subtitle);
    });
  });

  ///
  /// Test AndroidArg
  ///
  group('test AndroidArg', () {
    const String longLabel = "my long label";
    const String uri = "https://abc.com";

    test('test AndroidArg default constructor', () {
      const actual = AndroidArg();
      expect(actual.longLabel, '');
      expect(actual.uri, '');
    });
    test('test AndroidArg toMap', () {
      final expected = {
        "longLabel": longLabel,
        "uri": uri,
      };
      const actual = AndroidArg(longLabel: longLabel, uri: uri);
      expect(actual.toMap(), expected);
    });

    test('test AndroidArg fromMap valid data', () {
      const expected = AndroidArg(longLabel: longLabel, uri: uri);
      final inputMap = {
        "longLabel": longLabel,
        "uri": uri,
      };

      expect(AndroidArg.fromMap(inputMap).longLabel, expected.longLabel);
      expect(AndroidArg.fromMap(inputMap).uri, expected.uri);
    });

    test('test AndroidArg fromMap null longLabel', () {
      final inputMap = {"uri": uri};

      expect(AndroidArg.fromMap(inputMap).longLabel, '');
    });

    test('test AndroidArg fromMap null uri', () {
      final inputMap = {"longLabel": longLabel};

      expect(AndroidArg.fromMap(inputMap).uri, '');
    });

    test('test AndroidArg copyWith', () {
      const expected = AndroidArg(longLabel: longLabel, uri: uri);
      final actual = const AndroidArg().copyWith(
        longLabel: longLabel,
        uri: uri,
      );

      expect(actual.longLabel, expected.longLabel);
      expect(actual.uri, expected.uri);
    });
  });

  ///
  /// Test ShortcutArg
  ///
  group('test ShortcutArg', () {
    const String id = "id";
    const String title = "title";
    const String iconResourceName = "iconResourceName";
    const IosArg iosArg = IosArg();
    const String subtitle = "subtitle of ios";
    test('test ShortcutArg default constructor', () {
      final actual = ShortcutArg(id: id, title: title, iosArg: iosArg);
      expect(actual.id, id);
      expect(actual.title, title);
      expect(actual.iconResourceName, '');
      expect(actual.androidArg, null);
      expect(actual.iosArg, iosArg);
    });

    test('test ShortcutArg toMap valid data', () {
      final expected = {
        keyId: id,
        keyTitle: title,
        keyIconResourceName: iconResourceName,
        keyAndroidArg: null,
        keyIosArg: {"subtitle": subtitle},
        keyAndroidReadOnlyArg: null,
      };
      final actual = ShortcutArg(
          id: id,
          title: title,
          iconResourceName: iconResourceName,
          iosArg: iosArg.copyWith(subtitle: subtitle));
      expect(actual.toMap(), expected);
    });

    test('test ShortcutArg fromMap valid data', () {
      final inputMap = {
        "id": id,
        "title": title,
        "iconResourceName": iconResourceName,
        "iosArg": {"subtitle": subtitle}
      };
      final actual = ShortcutArg.fromMap(inputMap);

      expect(actual.id, id);
      expect(actual.title, title);
      expect(actual.iconResourceName, iconResourceName);
      expect(actual.androidArg, null);
      expect(actual.iosArg?.subtitle, subtitle);
    });

    test('test ShortcutArg toString', () {
      final actual = ShortcutArg(
        id: id,
        title: title,
        iconResourceName: iconResourceName,
        iosArg: iosArg,
      ).toString();

      expect(
        actual,
        "[ShortcutArg] id=$id, shortLabel=$title, "
        "iconResourceName=$iconResourceName, "
        "androidArg=${null}, "
        "androidReadOnlyArg=${null},"
        "iosArg=${iosArg.toMap()}",
      );
    });

    test('test ShortcutArg copyWith', () {
      final arg = ShortcutArg(
          id: id,
          title: title,
          androidArg: const AndroidArg(longLabel: 'Long label'));
      final actual = arg.copyWith(
          iconResourceName: iconResourceName,
          iosArg: iosArg.copyWith(subtitle: subtitle),
          androidArg: const AndroidArg());

      expect(actual.id, id);
      expect(actual.title, title);
      expect(actual.iconResourceName, iconResourceName);
      expect(actual.androidArg, const AndroidArg());
      expect(actual.iosArg?.subtitle, subtitle);
    });
  });

  group('test DisableShortcutArg', () {
    test('test DisableShortcutArg default constructor', () {
      const actual = DisableShortcutArg(id: 'id');

      expect(actual.id, 'id');
      expect(actual.reason, '');
    });
  });
}

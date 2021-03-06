import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_shortcut/flutter_app_shortcut.dart';
import 'package:flutter_app_shortcut/short_cut_arg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ShortcutArg> _shortcuts = [];
  FlutterAppShortcut flutterAppShortcut = FlutterAppShortcut();

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void initState() {
    super.initState();
    _removeShortcuts();
  }

  void _removeShortcuts() async {
    await flutterAppShortcut.removeAll();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App shortcut plugin example app'),
        ),
        body: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getAllBtn(),
                _setBtn(),
                _pushBtn(),
                _removeBtn(),
                _removeAllBtn(),
                _enableBtn(context),
                _disableBtn(context),
                Expanded(
                  child: ListView.builder(
                    itemCount: _shortcuts.length,
                    itemBuilder: (context, i) {
                      final item = _shortcuts[i];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.toString()),
                            ]),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ShortcutArg _randomShortcut() => ShortcutArg(
      id: getRandomString(5),
      title: getRandomString(10),
      iconResourceName: 'ic_android_black',
      flutterIconPath: 'asset/ios_shortcut.png',
      androidArg:
          const AndroidArg(uri: 'test://xxx', longLabel: "Very long label"),
      iosArg: const IosArg(subtitle: 'my subtitle'));

  Widget _getAllBtn() {
    return Builder(builder: (context) {
      return TextButton(
          onPressed: () async {
            final result = await flutterAppShortcut.getAll();
            var text = "";

            for (var element in result) {
              text += "id=" + element.id + "|";
            }
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(text)));
          },
          child: const Text('Get current shortcuts'));
    });
  }

  Widget _setBtn() {
    return TextButton(
        onPressed: () async {
          final newShortcuts = [
            _randomShortcut(),
            _randomShortcut(),
          ];
          await flutterAppShortcut.set(newShortcuts);
          setState(() {
            _shortcuts = newShortcuts;
          });
        },
        child: const Text('Set random shortcuts'));
  }

  Widget _pushBtn() {
    return TextButton(
        onPressed: () async {
          final shortcut = _randomShortcut();
          await flutterAppShortcut.push(shortcut);
          setState(() {
            _shortcuts.add(shortcut);
          });
        },
        child: const Text('Push 1 shortcut'));
  }

  Widget _removeBtn() {
    return TextButton(
        onPressed: () async {
          if (_shortcuts.isNotEmpty) {
            await flutterAppShortcut.removeById(_shortcuts.first.id);
            setState(() {
              _shortcuts.removeAt(0);
            });
          }
        },
        child: const Text('Remove 1 shortcut'));
  }

  Widget _removeAllBtn() {
    return TextButton(
        onPressed: () async {
          await flutterAppShortcut.removeAll();
          setState(() {
            _shortcuts.clear();
          });
        },
        child: const Text('Remove all shortcut'));
  }

  Widget _enableBtn(BuildContext context) {
    return Builder(
      builder: (ctx) => TextButton(
          onPressed: () async {
            if (_isIos(ctx)) {
              return;
            }
            await flutterAppShortcut
                .enableShortcuts(_shortcuts.map((e) => e.id).toList());
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Enabled all shortcuts')));
          },
          child: const Text('Enable all shortcuts')),
    );
  }

  bool _isIos(BuildContext context) {
    if (Platform.isIOS) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Function on available on IOS')));
      return true;
    }

    return false;
  }

  Widget _disableBtn(BuildContext context) {
    return Builder(
      builder: (ctx) => TextButton(
          onPressed: () async {
            if (_isIos(ctx)) {
              return;
            }
            await flutterAppShortcut.disableShortcuts(_shortcuts
                .map((e) =>
                    DisableShortcutArg(id: e.id, reason: 'Reason ${e.id}'))
                .toList());
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Disabled all shortcuts')));
          },
          child: const Text('Disable all shortcuts')),
    );
  }
}

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _setBtn(),
            _pushBtn(),
            _removeBtn(),
            _removeAllBtn(),
            _enableBtn(),
            _disableBtn(),
            Expanded(
              child: ListView.builder(
                itemCount: _shortcuts.length,
                itemBuilder: (context, i) {
                  final item = _shortcuts[i];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    color: item.enabled ? Colors.blueAccent : Colors.grey,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
        ),
      ),
    );
  }

  ShortcutArg _randomShortcut() => ShortcutArg(
      id: getRandomString(5),
      shortLabel: getRandomString(10),
      iconResourceName: 'ic_android_black',
      uri: 'https://www.google.com',
      );

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

  Widget _enableBtn() {
    return TextButton(
        onPressed: () async {
          await flutterAppShortcut
              .enableShortcuts(_shortcuts.map((e) => e.id).toList());
          setState(() {
            _shortcuts =
                _shortcuts.map((e) => e.copyWith(enabled: true)).toList();
          });
        },
        child: const Text('Enable shortcut'));
  }

  Widget _disableBtn() {
    return TextButton(
        onPressed: () async {
          await flutterAppShortcut
              .disableShortcuts(_shortcuts.map((e) => e.id).toList());
          setState(() {
            _shortcuts =
                _shortcuts.map((e) => e.copyWith(enabled: false)).toList();
          });
        },
        child: const Text('Disable shortcut'));
  }
}

# flutter_app_shortcut

A plugin to implement Android native App shortcut and IOS quick actions

<br>

Android          | IOS
:-------------------------:|:-------------------------:
![](/asset/android_shortcut.png)  |  ![](/asset/ios_shortcut.png)


# Getting Started

## Where to get it?
Go to the plugin official [pub.dev](https://pub.dev/packages/flutter_app_shortcut) page to install

<br>

## How to use it?

Review [this](/example/lib/main.dart) file to get full example usages

### Android
Add a new shortcut

```
FlutterAppShortcut().push(
    ShortcutArg(
        id: 'id_1',
        title: 'Home page',
        iconResourceName: 'ic_android_black',
        flutterIconPath: 'asset/ic_heart.png',
        androidArg: AndroidArg(
            longLabel: 'Go to Home page',
            uri: 'https://www.google.com',
        )
    );
)
```

Add a new icon with asset in native side
- Add icon resource to `android/app/src/main/res`
- Set `iconResourceName` to the same name as the added icon in previous step

Add a new icon with asset in flutter side
- Add icon resource to assets folder
- Add icon path to pubspec.yaml
- set `flutterIconPath` to your path in flutter asset folder. Ex `assets/ic_heart.png`

### IOS
```
FlutterAppShortcut().push(
    ShortcutArg(
        id: 'id_1',
        title: 'Home page',
        iconResourceName: 'register',
        iosArg: IosArg(subtitle: 'My subtitle'),
    );
)
```
Add a new icon
- Add image set using Xcode
- Set `iconResourceName` to the same name as the added icon in previous step


<br><br>

## Supported operations

'x' means the operation is supported on platform

| Name  | IOS | Android | Note
| ------------- | ------------- |  ------------- |   ------------- |
| getAll  | x | x |  |
| set | x | x |   |
| push | x | x |   |
| removeById | x | x |   |
| removeAll | x | x |   |
| enableShortcuts |  | x |  | 
| disableShortcuts |  | x | API < 24 -> disable == remove |
## Arguments

Arguments with platform prefix is only supported on said platform
For example: AndroidArg only supports Android

### ShortcutArg
| Name  | Type | Requirements | Description |
| ------------- | ------------- |  ------------- | ------------- |
| id  |  String  |  Unique, Not empty  | When pushing shortcuts with the same ID, the existing one is updated |
| title | String |  Not empty | App short cut label (title) | 
| iconResourceName | String |  | Icon resource name from native side (see below for usage) |
| flutterIconPath | String |  | Icon resource path from flutter side
| androidArg | AndroidArg |  | Extra arguments for Android shortcuts |
| androidReadOnlyArg | AndroidReadOnlyArg |  | Read only args when call get shortcuts, if set from dart side, nothing happens |
| iosArg | IosArg |  | Extra arguments for IOS shortcuts |

### AndroidArg
| Name  | Type | Requirements | Description |
| ------------- | ------------- |  ------------- | ------------- |
| longLabel | String |  | if there is enough space on the device, longLabel replaces title | 
| uri | String |  |Uri when click on shortcut | 

<br>

### IosArg
| Name  | Type | Requirements | Description |
| ------------- | ------------- |  ------------- | ------------- |
| subtitle | String |  | Subtitle of the shortcut |

<br><br>

# Limitations
Limitations by either platform or because this plugin does not support it yet
## Android
- Pinned shortcut cannot be removed, only disabled
- Shortcut after disabled cannot be enabled, however, pinned shortcut can
- Cannot return icon name when cal getShortcuts
- Max 4 shortcuts can be displayed at once
## IOS
- Cannot return icon name when cal getShortcuts
- Max 4 shortcuts can be displayed at once
- Cannot use icon from flutter side (will implement in the future)
- On click short cut does not support deeplink (will implement in the future)
<br><br>

# TODOs
## IOS
- [ ] Allow icon from flutter side
- [ ] Enable deeplink navigation on click shortcut
<br><br>

# Bugs, Ideas, and Feedback

For bugs please use [GitHub Issues](https://github.com/ngthailam/flutter_app_short_cut/issues). For questions, ideas, and discussions use [GitHub Discussions](https://github.com/ngthailam/flutter_app_short_cut/discussions).

<br><br>

# License

[See license](https://github.com/ngthailam/flutter_app_short_cut/blob/main/LICENSE)
# flutter_app_shortcut

A plugin to implement Android native App shortcut and IOS quick actions

<br>


# Getting Started



## Where to get it?
Go to the plugin official pub.dev page to install

<br>

## How to use it?

Review [this](/example/lib/main.dart) file to get full example usages

<br>

## Arguments

| Name  | Value | Requirements | Description | IOS | Android |
| ------------- | ------------- |  ------------- | ------------- | ------------- | ------------- |
| id  |  String  |  Unique  | When pushing shortcuts with the same ID, the existing one is updated | Yes | Yes |
| shortLabel | String |  Not empty | App short cut label | Yes | Yes |
| longLabel | String |   | App short cut label when there is a lot of space | No | Yes |
| iconResourceName | String |  | Icon resource name (see below for usage) | No | Yes |
| uri | String |  |Uri when click on shortcut | No | No |
| enabled | boolean |  | If enabled == false, user cannot interact with app shortcut | No | No |

<br>

## Example

### Android
Add a new shortcut

```
FlutterAppShortcut().push(
    ShortcutArg(
        id: 'id_1',
        shortLabel: 'Home page',
        longLabel: 'Go to Home page',
        iconResourceName: 'ic_android_black',
        uri: 'https://www.google.com',
        enabled: true,
    );
)
```

Add a new icon
- Add icon resource to `android/app/src/main/res`
- Set `iconResourceName` to the same name as the added icon in previous step

### IOS
```
FlutterAppShortcut().push(
    ShortcutArg(
        id: 'id_1',
        shortLabel: 'Home page',
    );
)
```

- Other fields are not supported yet

<br><br>

# Limitations

## Android
- Pinned shortcut cannot be removed, only disabled
- Cannot set disabled message (will implement in the future)
- Cannot use icon from flutter side (will implement in the future)
- On click short cut does nothing
## IOS
- On IOS, enable and disable shortcuts is not available
- Cannot use icon from flutter side (will implement in the future)
- On click short cut does nothing
<br><br>

# TODO
- [x] Reseach + Implement for IOS side
## Android
- [ ] Allow add disabled message to disabled shortcuts
- [ ] Implement get shortcuts
- [ ] Allow icon from flutter side
- [ ] Enable destination on click shortcut
- [ ] Provide accurate errors
## IOS
- [ ] Allow set subtitle
- [ ] Allow set icon
- [ ] Allow icon from flutter side
- [ ] Enable destination on click shortcut
- [ ] Provide accurate errors
<br><br>

# Bugs, Ideas, and Feedback

For bugs please use [GitHub Issues](https://github.com/ngthailam/flutter_app_short_cut/issues). For questions, ideas, and discussions use [GitHub Discussions](https://github.com/ngthailam/flutter_app_short_cut/discussions).

<br><br>

# License
```
Copyright 2021 The Flutter App Shortcuts Project Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
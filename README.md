# flutter_app_shortcut

A plugin to implement Android native App shortcut. 
I dont know if IOS has the same functionalities, if so, I will work on it next.

<br>


# Getting Started



## Where to get it?
Go to the plugin official pub.dev page to install

<br>

## How to use it?

Review [this](/example/lib/main.dart) file to get full example usages

<br>

## Arguments

| Name  | Value | Requirements | Description |
| ------------- | ------------- |  ------------- | ------------- |
| id  |  String  |  Unique  | When pushing shortcuts with the same ID, the existing one is updated |
| shortLabel | String |  Not empty | App short cut label |
| longLabel | String |   | App short cut label when there is a lot of space |
| iconResourceName | String |  | Icon resource name (see below for usage) |
| uri | String |  |Uri when click on shortcut |
| enabled | boolean |  | If enabled == false, user cannot interact with app shortcut |

<br>

## Android

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

<br><br>

# Limitations

## Android
- Pinned shortcut cannot be removed, only disabled
- Cannot set disabled message (will implement in the future)

<br><br>

# TODO
- [ ] Reseach + Implement for IOS side
- [ ] Allow add disabled message to disabled shortcuts
- [ ] Implement get shortcuts

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
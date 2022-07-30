const String keyId = "id";
const String keyTitle = "title";
const String keyIconResourceName = "iconResourceName";
const String keyFlutterIconPath = "flutterIconPath";
const String keyAndroidArg = "androidArg";
const String keyAndroidReadOnlyArg = "androidReadOnlyArg";
const String keyIosArg = "iosArg";

class ShortcutArg {
  /// Unique id to identify shortcuts
  final String id;

  /// Label of the shortcut
  final String title;

  /// App short cut leading icon from native asset
  final String iconResourceName;

  /// App short cut leading icon from flutter asset
  final String flutterIconPath;

  /// Args for Android only
  final AndroidArg? androidArg;

  /// Args for Android only
  /// These args contains read only details of the shortcut
  /// Such as enabled, isPinned, which cannot be send directly to native side
  /// to cause change, so they are readonly
  final AndroidReadOnlyArg? androidReadOnlyArg;

  /// Args for IOS only
  final IosArg? iosArg;

  ShortcutArg({
    required this.id,
    required this.title,
    this.iconResourceName = '',
    this.flutterIconPath = '',
    this.androidArg,
    this.androidReadOnlyArg,
    this.iosArg,
  })  : assert(id.isNotEmpty),
        assert(title.isNotEmpty);

  ShortcutArg copyWith({
    String? id,
    String? title,
    String? iconResourceName,
    String? flutterIconPath,
    AndroidArg? androidArg,
    AndroidReadOnlyArg? androidReadOnlyArg,
    IosArg? iosArg,
  }) =>
      ShortcutArg(
        id: id ?? this.id,
        title: title ?? this.title,
        iconResourceName: iconResourceName ?? this.iconResourceName,
        flutterIconPath: flutterIconPath ?? this.flutterIconPath,
        androidArg: androidArg ?? this.androidArg,
        androidReadOnlyArg: androidReadOnlyArg ?? this.androidReadOnlyArg,
        iosArg: iosArg ?? this.iosArg,
      );

  Map<String, dynamic> toMap() {
    return {
      keyId: id,
      keyTitle: title,
      keyIconResourceName: iconResourceName,
      keyFlutterIconPath: flutterIconPath,
      keyAndroidArg: androidArg?.toMap(),
      keyAndroidReadOnlyArg: androidReadOnlyArg?.toMap(),
      keyIosArg: iosArg?.toMap(),
    };
  }

  factory ShortcutArg.fromMap(Map<dynamic, dynamic> map) {
    return ShortcutArg(
      id: map[keyId] as String,
      title: map[keyTitle] as String,
      iconResourceName:
          map[keyIconResourceName] is String ? map[keyIconResourceName] : '',
      flutterIconPath:
          map[keyFlutterIconPath] is String ? map[keyFlutterIconPath] : '',
      androidArg: map[keyAndroidArg] is Map<dynamic, dynamic>
          ? AndroidArg.fromMap(map[keyAndroidArg])
          : null,
      androidReadOnlyArg: map[keyAndroidReadOnlyArg] is Map<dynamic, dynamic>
          ? AndroidReadOnlyArg.fromMap(map[keyAndroidReadOnlyArg])
          : null,
      iosArg: map[keyIosArg] is Map<dynamic, dynamic>
          ? IosArg.fromMap(map[keyIosArg])
          : null,
    );
  }

  @override
  String toString() {
    return "[ShortcutArg] id=$id, shortLabel=$title, "
        "iconResourceName=$iconResourceName, "
        "flutterIconPath=$flutterIconPath, "
        "androidArg=${androidArg?.toMap()}, "
        "androidReadOnlyArg=${androidReadOnlyArg?.toMap()},"
        "iosArg=${iosArg?.toMap()}";
  }
}

class AndroidArg {
  /// Label of the shortcut, if there is enough room, {longLabel} is used
  /// instead of label
  /// Default value is {shortLabel}
  final String longLabel;

  /// Uri of target destination when click on shortcut
  final String uri;

  const AndroidArg({this.longLabel = '', this.uri = ''});

  AndroidArg copyWith({
    String? longLabel,
    String? uri,
  }) =>
      AndroidArg(
        longLabel: longLabel ?? this.longLabel,
        uri: uri ?? this.uri,
      );

  Map<String, dynamic> toMap() {
    return {
      "longLabel": longLabel,
      "uri": uri,
    };
  }

  factory AndroidArg.fromMap(Map<dynamic, dynamic> map) {
    return AndroidArg(
      longLabel: map['longLabel'] is String ? map['longLabel'] : "",
      uri: map['uri'] is String ? map['uri'] : '',
    );
  }
}

class AndroidReadOnlyArg {
  final bool? isPinned;
  final String? disabledMsg;
  final bool? isEnabled;

  AndroidReadOnlyArg({this.isPinned, this.disabledMsg, this.isEnabled});

  Map<String, dynamic> toMap() {
    return {
      "isPinned": isPinned,
      "disabledMsg": disabledMsg,
      "isEnabled": isEnabled,
    };
  }

  factory AndroidReadOnlyArg.fromMap(Map<dynamic, dynamic> map) {
    return AndroidReadOnlyArg(
      isPinned: map['isPinned'] is String ? (map['isPinned'] == 'true') : null,
      disabledMsg: map['disabledMsg'] is String ? map['disabledMsg'] : '',
      isEnabled:
          map['isEnabled'] is String ? (map['isEnabled'] == 'true') : null,
    );
  }
}

class IosArg {
  /// Subtitle beneath title
  final String subtitle;

  const IosArg({this.subtitle = ''});

  IosArg copyWith({
    String? subtitle,
  }) =>
      IosArg(
        subtitle: subtitle ?? this.subtitle,
      );

  Map<String, dynamic> toMap() {
    return {
      "subtitle": subtitle,
    };
  }

  factory IosArg.fromMap(Map<dynamic, dynamic> map) {
    return IosArg(
      subtitle: map['subtitle'] is String ? map['subtitle'] : "",
    );
  }
}

class DisableShortcutArg {
  final String id;
  final String reason;

  const DisableShortcutArg({
    required this.id,
    this.reason = '',
  });
}

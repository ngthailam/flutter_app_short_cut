const String keyId = "id";
const String keyTitle = "title";
const String keyIconResourceName = "iconResourceName";
const String keyAndroidArg = "androidArg";
const String keyIosArg = "iosArg";

class ShortcutArg {
  /// Unique id to identify shortcuts
  final String id;

  /// Label of the shortcut
  final String title;

  /// App short cut leading icon
  final String iconResourceName;

  /// Args for Android only
  final AndroidArg? androidArg;

  /// Args for IOS only
  final IosArg? iosArg;

  ShortcutArg({
    required this.id,
    required this.title,
    this.iconResourceName = '',
    this.androidArg,
    this.iosArg,
  })  : assert(id.isNotEmpty),
        assert(title.isNotEmpty),
        assert(androidArg != null || iosArg != null);

  ShortcutArg copyWith({
    String? id,
    String? title,
    String? iconResourceName,
    AndroidArg? androidArg,
    IosArg? iosArg,
  }) =>
      ShortcutArg(
        id: id ?? this.id,
        title: title ?? this.title,
        iconResourceName: iconResourceName ?? this.iconResourceName,
        androidArg: androidArg ?? this.androidArg,
        iosArg: iosArg ?? this.iosArg,
      );

  Map<String, dynamic> toMap() {
    return {
      keyId: id,
      keyTitle: title,
      keyIconResourceName: iconResourceName,
      keyAndroidArg: androidArg?.toMap(),
      keyIosArg: iosArg?.toMap(),
    };
  }

  factory ShortcutArg.fromMap(Map<dynamic, dynamic> map) {
    return ShortcutArg(
      id: map['id'] as String,
      title: map['title'] as String,
      iconResourceName:
          (map['iconResourceName'] is String) ? map['iconResourceName'] : '',
      androidArg: (map[keyAndroidArg] is Map<dynamic, dynamic>)
          ? AndroidArg.fromMap(map[keyAndroidArg])
          : null,
      iosArg: (map[keyIosArg] is Map<dynamic, dynamic>)
          ? IosArg.fromMap(map[keyIosArg])
          : null,
    );
  }

  @override
  String toString() {
    return "[ShortcutArg] id=$id, shortLabel=$title, "
        "iconResourceName=$iconResourceName, "
        "androidArg=${androidArg?.toMap()}, iosArg=${iosArg?.toMap()}";
  }
}

class AndroidArg {
  /// Label of the shortcut, if there is enough room, {longLabel} is used
  /// instead of label
  /// Default value is {shortLabel}
  final String longLabel;

  /// Uri of target destination when click on shortcut
  final String uri;

  AndroidArg({this.longLabel = '', this.uri = ''});

  AndroidArg copyWith({
    String? longLabel,
    String? uri,
    bool? enabled,
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
      longLabel: map['longLabel'] as String,
      uri: map['uri'] as String,
    );
  }
}

class IosArg {
  /// Subtitle beneath title
  final String subtitle;

  IosArg({this.subtitle = ''});

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
      subtitle: map['subtitle'] as String,
    );
  }
}

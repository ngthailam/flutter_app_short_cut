class ShortcutArg {
  /// Unique id to identify shortcuts
  final String id;

  /// Label of the shortcut
  final String shortLabel;

  /// Label of the shortcut, if there is enough room, {longLabel} is used
  /// instead of label
  /// Default value is {shortLabel}
  final String longLabel;

  /// App short cut leading icon
  final String iconResourceName;

  /// Uri of target destination when click on shortcut
  final String uri;

  /// Tells whether the shortcut is enabled or not
  /// Setting this does NOT enable/disable the shortcut
  /// please use the FlutterAppShortcut class
  final bool enabled;

  ShortcutArg({
    required this.id,
    required this.shortLabel,
    this.longLabel = '',
    this.iconResourceName = '',
    this.uri = '',
    this.enabled = true,
  })  : assert(id.isNotEmpty),
        assert(shortLabel.isNotEmpty);

  ShortcutArg copyWith({
    String? id,
    String? shortLabel,
    String? longLabel,
    String? iconResourceName,
    String? uri,
    bool? enabled,
  }) =>
      ShortcutArg(
        id: id ?? this.id,
        shortLabel: shortLabel ?? this.shortLabel,
        longLabel: longLabel ?? this.longLabel,
        iconResourceName: iconResourceName ?? this.iconResourceName,
        uri: uri ?? this.uri,
        enabled: enabled ?? this.enabled,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shortLabel': shortLabel,
      'longLabel': longLabel,
      'iconResourceName': iconResourceName,
      'uri': uri,
      'enabled': enabled,
    };
  }

  factory ShortcutArg.fromMap(Map<dynamic, dynamic> map) {
    return ShortcutArg(
        id: map['id'] as String,
        shortLabel: map['shortLabel'] as String,
        longLabel: (map['longLabel'] is String) ? map['longLabel'] : '',
        iconResourceName: (map['iconResourceName'] is String) ? map['iconResourceName'] : '',
        uri: (map['uri'] is String) ? map['uri'] : '',
        enabled: (map['enabled'] is bool) ? map['enabled'] : true);
  }

  @override
  String toString() {
    return "[ShortcutArg] id=$id, shortLabel=$shortLabel, longLabel=$longLabel, iconResourceName=$iconResourceName, uri=$uri, enabled=$enabled";
  }
}

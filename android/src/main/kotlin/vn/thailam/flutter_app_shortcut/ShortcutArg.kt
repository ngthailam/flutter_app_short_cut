package vn.thailam.flutter_app_shortcut

import android.content.Intent
import androidx.core.content.pm.ShortcutInfoCompat

data class ShortcutArg(
    val id: String,
    val shortLabel: String,
    val longLabel: String = "",
    val iconResourceName: String = "",
    val uri: String = "",
) {
    companion object {
        fun fromInfoCompat(infoCompat: ShortcutInfoCompat): ShortcutArg {
            return ShortcutArg(
                id = infoCompat.id,
                shortLabel = infoCompat.shortLabel.toString(),
                longLabel = infoCompat.longLabel.toString(),
                uri = infoCompat.intent.toUri(Intent.URI_INTENT_SCHEME),
                iconResourceName = "",
            )
        }

        fun fromHashMap(map: Map<String, Any>): ShortcutArg {
            val shortLabel = map["shortLabel"] as String;
            return ShortcutArg(
                id = map["id"] as String,
                shortLabel = shortLabel,
                longLabel = map["longLabel"] as String,
                iconResourceName = map["iconResourceName"] as String,
                uri = map["uri"] as String
            )
        }
    }
}
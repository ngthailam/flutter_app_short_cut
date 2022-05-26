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
    fun toMap(): Map<String, Any> {
        return mapOf(
            "id" to id,
            "title" to shortLabel,
            "iconResourceName" to iconResourceName,
            "androidArg" to mapOf<String, Any>(
               "longLabel" to longLabel,
               "uri" to uri
            )
        )
    }

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
            val androidArg = map["androidArg"] as Map<String, Any>
            return ShortcutArg(
                id = map["id"] as String,
                shortLabel = map["title"] as String,
                longLabel = androidArg["longLabel"] as String,
                iconResourceName = map["iconResourceName"] as String,
                uri = androidArg["uri"] as String
            )
        }
    }
}

data class DisableShortcutArg(
    val id: String,
    val reason: String,
)

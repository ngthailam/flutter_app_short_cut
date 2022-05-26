package vn.thailam.flutter_app_shortcut

import android.content.Intent
import androidx.core.content.pm.ShortcutInfoCompat

data class ShortcutArg(
    val id: String,
    val shortLabel: String,
    val longLabel: String = "",
    val iconResourceName: String = "",
    val uri: String = "",
    val isPinned: Boolean? = null,
    val disabledMsg: String? = null,
    val isEnabled: Boolean? = null,
) {
    fun toMap(): Map<String, Any> {
        return mapOf(
            "id" to id,
            "title" to shortLabel,
            "iconResourceName" to iconResourceName,
            "androidArg" to mapOf<String, Any>(
               "longLabel" to longLabel,
               "uri" to uri
            ),
            "androidReadOnlyArg" to mapOf<String, Any>(
                "isPinned" to (isPinned?.toString() ?: "null"),
                "disabledMsg" to (disabledMsg ?: ""),
                "isEnabled" to (isEnabled?.toString() ?: "null"),
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
                isPinned = infoCompat.isPinned,
                isEnabled = infoCompat.isEnabled,
                disabledMsg = infoCompat.disabledMessage.toString()
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

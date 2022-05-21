package vn.thailam.flutter_app_shortcut

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import androidx.core.content.pm.ShortcutInfoCompat
import androidx.core.content.pm.ShortcutManagerCompat
import androidx.core.graphics.drawable.IconCompat

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.Exception

/** FlutterAppShortcutPlugin */
class FlutterAppShortcutPlugin : FlutterPlugin, MethodCallHandler {
    private var channel: MethodChannel? = null
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_app_shortcut")
        channel!!.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = null
        channel?.setMethodCallHandler(null)
        channel = null
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (applicationContext == null) {
            return result.error("Application context null", null, null)
        }

        val args: Map<String, Any>? = call.arguments as? Map<String, Any>
        when (call.method) {
            "getAllShortcuts" -> {
                return try {
                    val shortcuts = ShortcutManagerCompat.getDynamicShortcuts(applicationContext!!)
                    result.success(shortcuts.associate { it.id to ShortcutArg.fromInfoCompat(it) })
                } catch (t: Throwable) {
                    result.error("getAllShortcuts", t.message, args)
                }
            }
            "disableShortcuts" -> {
                return try {
                    val ids: List<String> = args?.toList()?.map { it.first }
                        ?: return result.error("disableShortcut", "Invalid args=$args", args)
                    ShortcutManagerCompat.disableShortcuts(applicationContext!!, ids, "Disabled")
                    result.success(true)
                } catch (t: Throwable) {
                    result.error("disableShortcut", t.message, args)
                }
            }
            "enableShortcuts" -> {
                return try {
                    val enabledIds = args?.toList()
                        ?.map { entry -> entry.first } ?: return result.error("enableShortcut", "Invalid args=$args", args)
                    val shortcutsDynamic = ShortcutManagerCompat.getShortcuts(applicationContext!!, ShortcutManagerCompat.FLAG_MATCH_DYNAMIC)
                    val shortcutsCached = ShortcutManagerCompat.getShortcuts(applicationContext!!, ShortcutManagerCompat.FLAG_MATCH_CACHED)
                    val shortcutsPinned = ShortcutManagerCompat.getShortcuts(applicationContext!!, ShortcutManagerCompat.FLAG_MATCH_PINNED)
                    val shortcutsToEnable = (shortcutsDynamic+ shortcutsCached + shortcutsPinned).filter {
                        enabledIds.contains(it.id)
                    }
                    ShortcutManagerCompat.enableShortcuts(applicationContext!!, shortcutsToEnable)
                    result.success(true)
                } catch (t: Throwable) {
                    result.error("enableShortcut", t.message, args)
                }
            }
            "setShortcuts" -> {
                return try {
                    if (args == null) return result.error("", "Arguments is null", null)
                    args.entries.map {
                        val shortcutArg = ShortcutArg.fromHashMap(it.value as Map<String, Any>)
                        pushShortcut(shortcutArg)
                    }
                    result.success(true)
                } catch (t: Throwable) {
                    result.error("setShortcuts", t.message, args)
                }
            }
            "pushShortcut" -> {
                return try {
                    if (args == null) return result.error("", "Arguments is null", null)
                    val shortcutArg = ShortcutArg.fromHashMap(args)
                    pushShortcut(shortcutArg)
                    result.success(true)
                } catch (t: Throwable) {
                    result.error("pushShortcut", t.message, args)
                }
            }
            "removeShortcut" -> {
                return try {
                    if (args == null) return result.error("", "Arguments is null", null)
                    if (args["id"] !is String) return result.error("Id invalid", "Expected map[id], given=$args", null)
                    val id = args["id"] as String
                    ShortcutManagerCompat.removeDynamicShortcuts(applicationContext!!, listOf(id))
                    result.success(true)
                } catch (t: Throwable) {
                    result.error("removeShortcut", t.message, args)
                }
            }
            "removeAllShortcuts" -> {
                return try {
                    ShortcutManagerCompat.removeAllDynamicShortcuts(applicationContext!!)
                    removeAllShortcuts()
                    result.success(true)
                } catch (t: Throwable) {
                    result.error("removeAllShortcuts", t.message, args)
                }
            }
            else -> result.notImplemented();
        }
    }

    private fun removeAllShortcuts() {
        with(applicationContext!!) {
            val shortcutsPinned = ShortcutManagerCompat.getShortcuts(applicationContext!!, ShortcutManagerCompat.FLAG_MATCH_PINNED)
            ShortcutManagerCompat.removeAllDynamicShortcuts(this)
            ShortcutManagerCompat.disableShortcuts(this, shortcutsPinned.map { it.id }, "Shortcut out of date, please remove")
        }
    }

    private fun pushShortcut(shortcutArg: ShortcutArg) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(shortcutArg.uri))
        val shortcutBuilder =
            ShortcutInfoCompat.Builder(applicationContext!!, shortcutArg.id)
                .setShortLabel(shortcutArg.shortLabel)
                .setLongLabel(shortcutArg.longLabel)
                .setIntent(intent)

        // Get resource icon
        if (shortcutArg.iconResourceName.trim().isNotEmpty()) {
            val resourceId: Int = applicationContext!!.resources
                .getIdentifier(
                    shortcutArg.iconResourceName,
                    "drawable",
                    applicationContext!!.packageName,
                )

            if (resourceId == 0) {
                throw InvalidResourceException("Invalid resourceId=$resourceId, did you forgot to add icon resource in android/app/src/main/res ?")
            }

            val iconCompat =
                IconCompat.createWithResource(applicationContext!!, resourceId)
            shortcutBuilder.setIcon(iconCompat)
        }

        ShortcutManagerCompat.pushDynamicShortcut(
            applicationContext!!,
            shortcutBuilder.build()
        )
    }
}

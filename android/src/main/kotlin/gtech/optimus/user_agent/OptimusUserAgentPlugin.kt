package gtech.optimus.user_agent

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.webkit.WebSettings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** OptimusUserAgentPlugin */
class OptimusUserAgentPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context
    private var constants: HashMap<Any, Any>? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "optimus_user_agent")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getProperties") {
            result.success(getProperties())
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getProperties(): Map<Any, Any>? {
        if (constants != null) {
            return constants
        }
        constants = HashMap()
        val packageManager: PackageManager = applicationContext.packageManager
        val packageName: String = applicationContext.packageName
        val shortPackageName = packageName.substring(packageName.lastIndexOf(".") + 1)
        var applicationName = ""
        var applicationVersion = ""
        var buildNumber = 0L
        val userAgent: String = getUserAgent()
        var packageUserAgent = userAgent
        try {
            val info = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.getPackageInfo(packageName, PackageManager.PackageInfoFlags.of(0L))
            } else {
                @Suppress("DEPRECATION")
                packageManager.getPackageInfo(packageName, 0)
            }
            applicationName =
                applicationContext.applicationInfo.loadLabel(applicationContext.packageManager)
                    .toString()
            applicationVersion = info.versionName ?: ""
            buildNumber = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                info.longVersionCode
            } else {
                @Suppress("DEPRECATION")
                info.versionCode.toLong()
            }
            packageUserAgent = "$shortPackageName/$applicationVersion.$buildNumber $userAgent"
        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }
        constants?.put("systemName", "Android")
        constants?.put("systemVersion", Build.VERSION.RELEASE)
        constants?.put("packageName", packageName)
        constants?.put("shortPackageName", shortPackageName)
        constants?.put("applicationName", applicationName)
        constants?.put("applicationVersion", applicationVersion)
        constants?.put("buildNumber", buildNumber)
        constants?.put("packageUserAgent", packageUserAgent)
        constants?.put("userAgent", userAgent)
        constants?.put("webViewUserAgent", getWebViewUserAgent())
        return constants
    }

    private fun getUserAgent(): String {
        return System.getProperty("http.agent")?.toString() ?: ""
    }

    private fun getWebViewUserAgent(): String {
        return WebSettings.getDefaultUserAgent(applicationContext)
    }
}

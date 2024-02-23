// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'optimus_user_agent_platform_interface.dart';

class OptimusUserAgent {
  static Map<dynamic, dynamic>? _properties;

  static Future init({force = false}) async {
    if (_properties == null || force) {
      await getProperties();
    }
  }

  static Future<Map<dynamic, dynamic>?> getProperties() async {
    _properties = await OptimusUserAgentPlatform.instance.getProperties();
    return _properties;
  }

  /// Returns the device's user agent.
  static String? get userAgent {
    return _properties!['userAgent'];
  }

  /// Returns the device's webview user agent.
  static String? get webViewUserAgent {
    return _properties!['webViewUserAgent'];
  }

  /// Fetch a [property] that can be used to build your own user agent string.
  static dynamic getProperty(String property) {
    return _properties![property];
  }

  /// Fetch a [property] asynchronously that can be used to build your own user agent string.
  static dynamic getPropertyAsync(String property) async {
    await init();
    return _properties![property];
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'optimus_user_agent_platform_interface.dart';

/// An implementation of [OptimusUserAgentPlatform] that uses method channels.
class MethodChannelOptimusUserAgent extends OptimusUserAgentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('optimus_user_agent');

  @override
  Future<Map<dynamic, dynamic>?> getProperties() async {
    final properties =
        Map.unmodifiable(await (methodChannel.invokeMethod('getProperties')));
    return properties;
  }
}

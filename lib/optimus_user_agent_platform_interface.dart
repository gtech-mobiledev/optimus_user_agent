import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'optimus_user_agent_method_channel.dart';

abstract class OptimusUserAgentPlatform extends PlatformInterface {
  /// Constructs a OptimusUserAgentPlatform.
  OptimusUserAgentPlatform() : super(token: _token);

  static final Object _token = Object();

  static OptimusUserAgentPlatform _instance = MethodChannelOptimusUserAgent();

  /// The default instance of [OptimusUserAgentPlatform] to use.
  ///
  /// Defaults to [MethodChannelOptimusUserAgent].
  static OptimusUserAgentPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OptimusUserAgentPlatform] when
  /// they register themselves.
  static set instance(OptimusUserAgentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<dynamic, dynamic>?> getProperties() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

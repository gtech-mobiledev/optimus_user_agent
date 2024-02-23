import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimus_user_agent/optimus_user_agent.dart';
import 'package:optimus_user_agent/optimus_user_agent_platform_interface.dart';
import 'package:optimus_user_agent/optimus_user_agent_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

Map<String, dynamic> sample = {
  'userAgent': 'result',
  'webViewUserAgent': 'result-webViewUserAgent',
};

class MockOptimusUserAgentPlatform
    with MockPlatformInterfaceMixin
    implements OptimusUserAgentPlatform {
  @override
  Future<Map<String, dynamic>?> getProperties() => Future.value(sample);
}

void main() {
  final OptimusUserAgentPlatform initialPlatform =
      OptimusUserAgentPlatform.instance;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  test('$MethodChannelOptimusUserAgent is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOptimusUserAgent>());
  });

  test('getProperties', () async {
    OptimusUserAgent.init();
    MockOptimusUserAgentPlatform fakePlatform = MockOptimusUserAgentPlatform();
    OptimusUserAgentPlatform.instance = fakePlatform;

    expect(await OptimusUserAgent.getProperties(), sample);
  });
}

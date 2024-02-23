import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimus_user_agent/optimus_user_agent_method_channel.dart';

Map<String, dynamic> sample = {
  'userAgent': 'result',
  'webViewUserAgent': 'result-webViewUserAgent',
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelOptimusUserAgent platform = MethodChannelOptimusUserAgent();
  const MethodChannel channel = MethodChannel('optimus_user_agent');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return sample;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getProperties', () async {
    expect(await platform.getProperties(), sample);
  });
}

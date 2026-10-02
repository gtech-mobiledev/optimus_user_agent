import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:optimus_user_agent/optimus_user_agent.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('retrieves properties through the native plugin', (tester) async {
    final properties = await OptimusUserAgent.getProperties();
    expect(properties, isNotNull);
    expect(properties!['systemName'], 'iOS');
    expect(properties['isEmulator'], isA<bool>());
    expect(properties['userAgent'],
        isA<String>().having((s) => s.isNotEmpty, 'not empty', true));
    expect(properties['packageUserAgent'],
        isA<String>().having((s) => s.isNotEmpty, 'not empty', true));
    expect(properties, contains('webViewUserAgent'));
    expect(properties['webViewUserAgent'], anyOf(isNull, isA<String>()));
    expect(OptimusUserAgent.userAgent, properties['userAgent']);
  });
}

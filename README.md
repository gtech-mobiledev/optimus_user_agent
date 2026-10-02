# optimus_user_agent

Retrieve Android/iOS device user agents in Flutter.

### iOS dependency managers

The plugin supports Swift Package Manager (SPM) and CocoaPods using the same
Objective-C implementation. The Dart API and returned properties are unchanged.

With Flutter 3.44 or later, Flutter discovers
`ios/optimus_user_agent/Package.swift` automatically when SPM is enabled. Flutter
provides its local `FlutterFramework` dependency during the app build; this is
not a standalone Swift package to resolve outside a Flutter app.

The SPM manifest declares iOS 13; the CocoaPods podspec retains iOS 11. The actual
app minimum must also satisfy the installed Flutter SDK. The migrated example
uses Flutter 3.44+ and iOS 15, as required by the Flutter 3.47 SDK used to build it.
Existing CocoaPods consumers can continue using the plugin without migrating.

The example uses SPM only and contains no CocoaPods integration. The plugin
podspec remains available for CocoaPods consumers.
The optional Xcode source-package override is omitted: Flutter 3.47 can generate
a conflicting package identity when this repository is checked out as
`optimus-user-agent`. The generated SPM dependency still compiles the local
plugin sources; no checkout-directory-specific package paths are committed.

### iOS verification

Run package checks from the repository root:

```sh
flutter test --concurrency=1
flutter analyze lib test example/integration_test
swift package --package-path ios/optimus_user_agent dump-package
ruby -c ios/optimus_user_agent.podspec
```

Build and exercise the example on an available iOS simulator:

```sh
cd example
flutter build ios --simulator --debug
flutter test integration_test/user_agent_test.dart -d <simulator-id>
cd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Debug \
  -destination 'platform=iOS Simulator,id=<simulator-id>' -only-testing:RunnerTests test
```

For CocoaPods verification, create a temporary iOS host outside this repository
with `flutter create --platforms=ios --project-name user_agent_pods <temp-path>`.
Add a path dependency on this repository and the following configuration in
the host's `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  optimus_user_agent:
    path: /absolute/path/to/optimus-user-agent
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
flutter:
  config:
    enable-swift-package-manager: false
  uses-material-design: true
```

Copy `example/integration_test/user_agent_test.dart` into the temporary host's
`integration_test/` directory. Run `flutter pub get`,
`flutter build ios --simulator --debug`, and the integration test command above
from that host. Flutter will set up CocoaPods there; verify its Podfile.lock lists
`optimus_user_agent`. Keep generated host files outside this repository.

### Example user-agents:

| System | User-Agent | WebView User-Agent |
| ------ | ---------- | ------------------ |
| iOS    | CFNetwork/897.15 Darwin/17.5.0 (iPhone/6s iOS/11.3) | Mozilla/5.0 (iPhone; CPU iPhone OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E217 |
| Android | Dalvik/2.1.0 (Linux; U; Android 5.1.1; Android SDK built for x86 Build/LMY48X) | Mozilla/5.0 (Linux; Android 5.1.1; Android SDK built for x86 Build/LMY48X) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36 |

### Additionally:

Every version returns some additional constants that might be useful for custom user-agent building.

iOS version returns:
- isEmulator
- systemName
- systemVersion
- applicationName
- applicationVersion
- buildNumber
- darwinVersion
- cfnetworkVersion
- deviceName
- packageUserAgent

Android version returns:
- systemName
- systemVersion
- packageName
- shortPackageName
- applicationName
- applicationVersion
- buildNumber
- packageUserAgent

### Credits 👍

Based of https://github.com/flutter-fast-kit/fk_user_agent

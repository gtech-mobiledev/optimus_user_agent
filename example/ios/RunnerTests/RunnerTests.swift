import Flutter
import UIKit
import XCTest
import optimus_user_agent

class RunnerTests: XCTestCase {
  func testGetProperties() {
    let resultExpectation = expectation(description: "properties returned")
    DispatchQueue.main.async {
      let plugin = OptimusUserAgentPlugin()
      plugin.handle(FlutterMethodCall(methodName: "getProperties", arguments: nil)) { result in
        guard let properties = result as? [String: Any] else {
          XCTFail("Expected a properties dictionary")
          resultExpectation.fulfill()
          return
        }
        let keys = ["isEmulator", "systemName", "systemVersion", "applicationName",
                    "applicationVersion", "buildNumber", "darwinVersion", "cfnetworkVersion",
                    "deviceName", "packageUserAgent", "userAgent", "webViewUserAgent"]
        XCTAssertEqual(Set(properties.keys), Set(keys))
        XCTAssertEqual(properties["systemName"] as? String, UIDevice.current.systemName)
        XCTAssertFalse((properties["userAgent"] as? String ?? "").isEmpty)
        XCTAssertFalse((properties["packageUserAgent"] as? String ?? "").isEmpty)
        XCTAssertTrue(properties["webViewUserAgent"] is String || properties["webViewUserAgent"] is NSNull)
        // Keep the plugin and its web view alive until JavaScript completes.
        withExtendedLifetime(plugin) { resultExpectation.fulfill() }
      }
    }
    waitForExpectations(timeout: 30)
  }

  func testUnknownMethod() {
    let resultExpectation = expectation(description: "unknown method returned")
    OptimusUserAgentPlugin().handle(FlutterMethodCall(methodName: "unknown", arguments: nil)) { result in
      XCTAssertTrue((result as AnyObject?) === FlutterMethodNotImplemented)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }
}

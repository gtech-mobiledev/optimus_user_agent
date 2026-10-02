// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "optimus_user_agent",
    platforms: [.iOS("13.0")],
    products: [
        .library(name: "optimus-user-agent", targets: ["optimus_user_agent"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "optimus_user_agent",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            publicHeadersPath: "include",
            cSettings: [.headerSearchPath("include/optimus_user_agent")],
            linkerSettings: [.linkedFramework("UIKit"), .linkedFramework("WebKit")]
        )
    ]
)

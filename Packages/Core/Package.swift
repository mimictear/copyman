// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-collections.git",
            .upToNextMajor(from: "1.1.0")
        )
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "Collections", package: "swift-collections")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]),
    ]
)

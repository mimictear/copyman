// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnticsUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AnticsUI",
            targets: ["AnticsUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/elai950/AlertToast.git", branch: "master")
    ],
    targets: [
        .target(
            name: "AnticsUI",
            dependencies: [
                .product(name: "AlertToast", package: "AlertToast")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        )
    ]
)

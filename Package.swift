// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWLabel",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "WWLabel", targets: ["WWLabel"]),
    ],
    targets: [
        .target(name: "WWLabel", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)

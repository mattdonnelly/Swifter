// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Swifter",
    platforms: [
        .macOS(.v10_10), .iOS(.v10)
    ],
    products: [
        .library(name: "Swifter", targets: ["Swifter"]),
    ],
    targets: [
        .target(
            name: "Swifter",
            path: "Sources"
        ),
    ]
)

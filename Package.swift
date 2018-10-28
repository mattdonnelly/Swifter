// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Swifter",
    products: [
        .library(name: "Swifter", targets: ["Swifter"]),
    ],
    targets: [
        .target(
            name: "Swifter",
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v4_2]
)

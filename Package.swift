// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Evotor",
    products: [
        .library(name: "Evotor", targets: ["Evotor"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Evotor", dependencies: []),
        .testTarget(name: "EvotorTests", dependencies: ["Evotor"])
    ]
)

// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "OsConectLocalApp",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "OsConectLocalApp",
            targets: ["OsConectLocalApp"])
    ],
    dependencies: [
        // Add any external dependencies here
    ],
    targets: [
        .target(
            name: "OsConectLocalApp",
            dependencies: []),
        .testTarget(
            name: "OsConectLocalAppTests",
            dependencies: ["OsConectLocalApp"]),
    ]
)
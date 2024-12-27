// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleNetworkManager",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v1),
        .macCatalyst(.v18),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SimpleNetworkManager",
            targets: ["SimpleNetworkManager"]
        ),
    ],
    dependencies: [
        .package(url: "https://www.github.com/Alamofire/Alamofire.git", "5.10.0"..<"6.0.0"),
        .package(url: "https://www.github.com/bradwindy/RichError.git", "2.1.0"..<"3.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SimpleNetworkManager",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "RichError", package: "RichError"),
            ]
        ),
    ]
)

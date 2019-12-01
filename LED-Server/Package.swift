// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HelloKitura",
    dependencies: [
    .package(url: "https://github.com/IBM-Swift/Kitura", from: "2.7.0"),
    .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.1.10"),
    .package(url: "https://github.com/uraimo/WS281x.swift.git", from: "2.0.4")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "HelloKitura",
            dependencies: ["Kitura", "SwiftyGPIO", "WS281x"]),
        .testTarget(
            name: "HelloKituraTests",
            dependencies: ["HelloKitura"]),
    ]
)

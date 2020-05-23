// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GivenWhenThen",
    products: [
        .library(
            name: "GivenWhenThen",
            targets: ["GivenWhenThen"]),
    ],
    targets: [
        .target(
            name: "GivenWhenThen",
            dependencies: []),
        .target(
            name: "Example",
            dependencies: []),
        .testTarget(
            name: "ExampleTests",
            dependencies: ["Example", "GivenWhenThen"]),
    ]
)

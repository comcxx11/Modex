// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modex",
    platforms: [
        .iOS(.v15), .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Modex",
            targets: ["Modex"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        // 실행 가능한 타겟 (Executable Target)
        .executableTarget(
            name: "A",
            dependencies: ["Modex"] // 필요한 라이브러리 추가 가능
        ),
        .executableTarget(
            name: "B",
            dependencies: ["Modex"] // 필요한 라이브러리 추가 가능
        ),
        .target(
            name: "Modex"),
        .testTarget(
            name: "ModexTests",
            dependencies: ["Modex"]
        ),
    ]
)

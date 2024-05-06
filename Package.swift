// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TTTAttributedLabel",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TTTAttributedLabel",
            targets: ["TTTAttributedLabel"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/gutenbergn/FuzeUtils.git", exact: "0.6.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TTTAttributedLabel",
            dependencies: ["FuzeUtils"],
            path: "TTTAttributedLabel",
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("CoreText", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("CoreGraphics", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("QuartzCore", .when(platforms: [.iOS, .tvOS]))
            ]
        ),
        //.testTarget(
        //    name: "FuzeUtilsTests",
        //    dependencies: ["FuzeUtils"]),
    ]
)
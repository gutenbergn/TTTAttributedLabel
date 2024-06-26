// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TTTAttributedLabel",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TTTAttributedLabel",
            targets: ["TTTAttributedLabel", "TTTAttributedLabelObjC"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/gutenbergn/FuzeUtils.git", .upToNextMajor(from: "0.6.2")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TTTAttributedLabel",
            dependencies: ["TTTAttributedLabelObjC", "FuzeUtils"],
            path: "TTTAttributedLabel/Swift",
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("CoreText", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("CoreGraphics", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("QuartzCore", .when(platforms: [.iOS, .tvOS]))
            ]
        ),
        .target(
            name: "TTTAttributedLabelObjC",
            path: "TTTAttributedLabel/ObjC",
            publicHeadersPath: "Headers",
            cSettings: [
                .headerSearchPath("Headers")
            ]
        )
        //.testTarget(
        //    name: "FuzeUtilsTests",
        //    dependencies: ["FuzeUtils"]),
    ]
)
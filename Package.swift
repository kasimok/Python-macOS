// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Python-macOS",
    platforms: [.macOS("10.10")],
    products: [
        .library(
            name: "Python-macOS",
            targets: [ // order matters!
                "LinkPython",
                "libpython3",
                "libopenssl",
                "libffi",
                "libxz", //AKA LZMA
                "libbz2",
                "PythonSupport",
            ]),
    ],
    targets: [
        .binaryTarget(name: "libpython3", path: "XCFrameworks/libpython3.xcframework.zip"),
        .binaryTarget(name: "libopenssl", path: "XCFrameworks/libopenssl.xcframework.zip"),
        .binaryTarget(name: "libffi", path: "XCFrameworks/libffi.xcframework.zip"),
        .binaryTarget(name: "libbz2", path: "XCFrameworks/libbz2.xcframework.zip"),
        .binaryTarget(name: "libxz", path: "XCFrameworks/libxz.xcframework.zip"),
        .target(name: "LinkPython",
                dependencies: [
                    "libpython3",
                    "libopenssl",
                    "libffi",
                    "libbz2",
                    "libxz"
                ],
                linkerSettings: [
                    .linkedLibrary("z"),
//                    .linkedLibrary("bz2"), //TODO: Test using system version
                    .linkedLibrary("sqlite3"),
                    .linkedFramework("SystemConfiguration")
                ]
        ),
        .target(name: "PythonSupport",
                dependencies: ["LinkPython"],
                resources: [.copy("lib")]),
        .testTarget(
            name: "PythonTests",
            dependencies: ["PythonSupport"]),
    ]
)

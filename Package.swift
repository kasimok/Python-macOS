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
        .binaryTarget(name: "libpython3",
                      url: "https://github.com/kasimok/Python-macOS/releases/download/0.01/libpython3.xcframework.zip",
                      checksum: "f8ec4d90703cd0f55b4f48b5365ef9f9fc6f20ef8ba29e20b72df71b4d979eda"),
        .binaryTarget(name: "libopenssl",
                      url: "https://github.com/kasimok/Python-macOS/releases/download/0.01/libopenssl.xcframework.zip",
                      checksum: "be04dc2164929df3d51a701120acdf1bdf5a5208577d02d4dc3921f34276ea07"),
        .binaryTarget(name: "libffi",
                      url: "https://github.com/kasimok/Python-macOS/releases/download/0.01/libffi.xcframework.zip",
                      checksum: "2bb6c31dec1129a9437d5959a75b023005454072df68ea97226db11f7b837342"),
        .binaryTarget(name: "libbz2",
                      url: "https://github.com/kasimok/Python-macOS/releases/download/0.01/libbz2.xcframework.zip",
                      checksum: "0278f3ff65f3a80eef1785947c76659e88a97f9cca0602bd4cf84545351818ba"),
        .binaryTarget(name: "libxz",
                      url: "https://github.com/kasimok/Python-macOS/releases/download/0.01/libxz.xcframework.zip",
                      checksum: "0d41aac6428183c998b930f85255f2762ee34150d216c3603316d99c74599a7e"),
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

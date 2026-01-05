// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "system_date_time_format",
    platforms: [
        .macOS("10.14")
    ],
    products: [
        .library(name: "system-date-time-format", targets: ["system_date_time_format"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "system_date_time_format",
            dependencies: [],
            resources: []
        )
    ]
)

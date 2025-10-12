// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "Kits",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .singleTargetLibrary("DesignKit"),
        .singleTargetLibrary("FirebaseKit"),
        .singleTargetLibrary("FirebaseKitLive"),
        .singleTargetLibrary("NavigationKit"),
        .singleTargetLibrary("UtilityKit")
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.4.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", exact: "1.10.0")
    ],
    targets: [
        .projectTarget(
            name: "DesignKit",
            dependencies: [
                "UtilityKit"
            ],
            resources: [.process("Assets")]
        ),
        .projectTarget(
            name: "FirebaseKit",
            dependencies: ["DesignKit", "UtilityKit"]
        ),
        // by making isolated firebase live kit we managed to fix Firebase linking issues in previews
        .projectTarget(
            name: "FirebaseKitLive",
            dependencies: [
                "DesignKit",
                "FirebaseKit",
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                "UtilityKit"
            ]
        ),
        .projectTarget(
            name: "NavigationKit",
            dependencies: [
                "UtilityKit",
                "FirebaseKit"
            ]
        ),
        .projectTarget(
            name: "UtilityKit",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies")
            ],
            resources: [.process("Resources")]
        )
    ]
)


// MARK: - Helpers

extension Product {
    
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}


extension Target {
    
    static func projectTarget(
        name: String,
        dependencies: [Target.Dependency] = [],
        exclude: [String] = [],
        sources: [String]? = nil,
        resources: [Resource]? = nil,
        publicHeadersPath: String? = nil,
        packageAccess: Bool = true,
        cSettings: [CSetting]? = nil,
        cxxSettings: [CXXSetting]? = nil,
        swiftSettings: [SwiftSetting]? = nil,
        linkerSettings: [LinkerSetting]? = nil,
        plugins: [Target.PluginUsage]? = nil
    ) -> Target {
        Target.target(
            name: name,
            dependencies: dependencies,
            path: "\(name)/Sources",
            exclude: exclude,
            sources: sources,
            resources: resources,
            publicHeadersPath: publicHeadersPath,
            cSettings: cSettings,
            cxxSettings: cxxSettings,
            swiftSettings: [SwiftSetting](),
            linkerSettings: linkerSettings,
            plugins: plugins
        )
    }
}

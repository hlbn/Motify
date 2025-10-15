// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "Kits",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: [
        .singleTargetLibrary("DesignKit"),
        .singleTargetLibrary("DataKit"),
        .singleTargetLibrary("FirebaseKit"),
        .singleTargetLibrary("NavigationKit"),
        .singleTargetLibrary("UtilityKit")
    ],
    dependencies: [
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", from: "24.0.0"),
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
            name: "DataKit",
            dependencies: [
                "DesignKit",
                "UtilityKit",
                .product(name: "KeychainSwift", package: "keychain-swift")
            ]
        ),
        // by making isolated firebase kit we managed to fix Firebase linking issues in previews
        .projectTarget(
            name: "FirebaseKit",
            dependencies: [
                "DesignKit",
                "DataKit",
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
                "DataKit"
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

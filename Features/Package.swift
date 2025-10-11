// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "Features",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .singleTargetLibrary("AuthFeature"),
        .singleTargetLibrary("ExerciseFeature")
    ],
    dependencies: [
        .package(path: "../Kits"),
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", from: "24.0.0")
    ],
    targets: [
        .projectTarget(
            name: "AuthFeature",
            dependencies: [
                .kit("DesignKit"),
                .kit("FirebaseKit"),
                .kit("NavigationKit"),
                .kit("UtilityKit"),
                .product(name: "KeychainSwift", package: "keychain-swift")
            ]
        ),
        .projectTarget(
            name: "ExerciseFeature",
            dependencies: [
                .kit("DesignKit"),
                .kit("FirebaseKit"),
                .kit("NavigationKit"),
                .kit("UtilityKit")
            ]
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
            swiftSettings: nil,
            linkerSettings: linkerSettings,
            plugins: plugins
        )
    }
}


extension Target.Dependency {
    static func kit(_ name: String) -> Target.Dependency {
        .product(name: name, package: "Kits")
    }
}

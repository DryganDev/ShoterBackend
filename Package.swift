// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ShoterBackend",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        
        .package(url: "https://github.com/vapor/multipart.git", from: "3.0.0"),
        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgresql", from: "1.0.0"),
         .package(url: "https://github.com/vapor/database-kit.git", from: "1.0.0"),
        // .package(url: "https://github.com/MihaelIsaev/SwifQL.git", from:"0.9.0"),
        // 👤 Authentication and Authorization layer for Fluent.
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0"),
    ],
    targets: [
        .target(name: "App",
                dependencies: ["Authentication",
                               "FluentSQLite",
                               "FluentPostgreSQL",
                               "DatabaseKit",
//                               "SwifQL",
//                               "SwifQLVapor",
                               "Vapor",
                               "Multipart"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)


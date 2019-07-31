import Authentication
import FluentSQLite
import FluentPostgreSQL
//import DatabaseKit
//import PostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentSQLiteProvider())
    try services.register(FluentPostgreSQLProvider())
    try services.register(AuthenticationProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(SessionsMiddleware.self) // Enables sessions.
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)
    // Configure a PostgreSQL database
    let postgreConfig = PostgreSQLDatabaseConfig(hostname: "localhost",
                                                 port: 5432,
                                                 username: "drygan",
                                                 database: "shoter",
                                                 password: nil,
                                                 transport: .cleartext)
    let postgresql = PostgreSQLDatabase(config: postgreConfig)

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.enableLogging(on: .sqlite)
    databases.add(database: sqlite, as: .sqlite)
    databases.add(database: postgresql, as: .psql)
    services.register(databases)
    
    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .sqlite)
    migrations.add(model: UserToken.self, database: .sqlite)
    migrations.add(model: Todo.self, database: .sqlite)
    
    services.register(migrations)

    
    var postgreMigration = MigrationConfig()
    postgreMigration.add(model: UserDB.self, database: .psql)
    services.register(postgreMigration)
}


final class UserDB: PostgreSQLModel {
    
    var id: Int?
    var name: String
    
}

extension UserDB: Content { }

extension UserDB: Authenticatable { }

extension UserDB: Parameter { }

extension UserDB: Migration { }

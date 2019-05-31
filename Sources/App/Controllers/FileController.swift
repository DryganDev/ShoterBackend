import Foundation
import Vapor
// Save file in system

let directory: URL = {
    let fileManager = FileManager.default
    if #available(OSX 10.12, *) {
        return fileManager.homeDirectoryForCurrentUser
    } else {
        return fileManager.urls(for: .userDirectory, in: .allDomainsMask)[0]
    }
}()

final class FileController {
    
    func save(_ req: Request) throws -> Future<HTTPStatus> {
//        /// Logs a user in, returning a token for accessing protected endpoints.
//        // get user auth'd by basic auth middleware
//        let user = try req.requireAuthenticated(User.self)
//        
//        // create new token for this user
//        let token = try UserToken.create(userID: user.requireID())
//
//        // save and return token
//        return token.save(on: req)
//        let file = File(data: LosslessDataConvertible, filename: String)
//        return req.future(file)
        return try req.content.decode(UploadFile.self).map(to: HTTPStatus.self) { file in
            let fileManager = FileManager.default
            let trySaveURL = directory.appendingPathComponent(file.content.filename).appendingPathExtension("jpeg")
            if !fileManager.fileExists(atPath: trySaveURL.absoluteString) {
                do {
                    try file.content.data.write(to: trySaveURL, options: .withoutOverwriting)
                    return .ok
                } catch {
                    throw Abort(.notAcceptable, reason: "olololo")
                }
            }
            return .ok
        }
    }
    
}

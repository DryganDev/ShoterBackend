import Foundation
import Vapor
// Save file in system
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
            print(file)
            return .ok
        }
//            req.content.decode(<#T##content: Decodable.Protocol##Decodable.Protocol#>)
    }
    
}

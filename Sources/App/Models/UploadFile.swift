import Foundation
import Vapor

final class UploadFile {
    let content: File
    
    init(content: File) {
        self.content = content
    }
}

extension UploadFile: Content { }

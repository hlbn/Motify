//

import Foundation
import FirebaseAuth


public struct AuthClient {
    public var login: (_ username: String, _ password: String) async throws -> Void
    public var register: (_ username: String, _ password: String) async throws -> Void
    public var logout: () throws -> Void
    public var getCurrentUser: () -> User?
}


// MARK: - Preview

public extension AuthClient {
    
    static var preview: Self {
        .init { _, _ in
            // do nothing
        } register: { _, _ in
            // do nothing
        } logout: {
            // do nothing
        } getCurrentUser: {
            nil
        }
    }
}

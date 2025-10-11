//

import Foundation
import Dependencies


public struct AuthClient: Sendable {
    public var login: @Sendable (_ username: String, _ password: String) async throws -> Void
    public var register: @Sendable (_ username: String, _ password: String) async throws -> Void
    public var logout: @Sendable () throws -> Void
    public var getCurrentUserId: @Sendable () -> String?
    
    public init(
        login: @Sendable @escaping (_: String, _: String) async throws -> Void,
        register: @Sendable @escaping (_: String, _: String) async throws -> Void,
        logout: @Sendable @escaping () throws -> Void,
        getCurrentUserId: @Sendable @escaping () -> String?
    ) {
        self.login = login
        self.register = register
        self.logout = logout
        self.getCurrentUserId = getCurrentUserId
    }
}


// MARK: - Preview

extension AuthClient: TestDependencyKey {
    
    public static var previewValue: AuthClient { testValue }
    public static var testValue: AuthClient {
        AuthClient(
            login: { _, _ in },
            register: { _, _ in },
            logout: { },
            getCurrentUserId: { nil }
        )
    }
}

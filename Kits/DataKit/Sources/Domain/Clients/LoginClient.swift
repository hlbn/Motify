//

import Dependencies
import UtilityKit


public struct LoginClient: Sendable {
    @Property public var savedCredentials: LoginCredentials?
    public var purgeCredentialsIfNeeded: @Sendable () -> Void
    
    public init(savedCredentials: Property<LoginCredentials?>, purgeCredentialsIfNeeded: @Sendable @escaping () -> Void) {
        self._savedCredentials = savedCredentials
        self.purgeCredentialsIfNeeded = purgeCredentialsIfNeeded
    }
}


// MARK: - Preview

extension LoginClient: TestDependencyKey {
    
    public static var previewValue: LoginClient { testValue }
    public static var testValue: LoginClient {
        LoginClient(
            savedCredentials: .constant(nil),
            purgeCredentialsIfNeeded: { }
        )
    }
}

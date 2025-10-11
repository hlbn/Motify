//

import Dependencies
import UtilityKit


struct LoginClient: Sendable {
    @Property var savedCredentials: LoginCredentials?
    var purgeCredentialsIfNeeded: @Sendable () -> Void
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

//

import UtilityKit


struct LoginClient: Sendable {
    @Property var savedCredentials: LoginCredentials?
    var purgeCredentialsIfNeeded: @Sendable () -> Void
}


// MARK: - Preview

extension LoginClient {
    
    static var preview: Self {
        .init(
            savedCredentials: .constant(nil),
            purgeCredentialsIfNeeded: {
                // do nothing
            }
        )
    }
}

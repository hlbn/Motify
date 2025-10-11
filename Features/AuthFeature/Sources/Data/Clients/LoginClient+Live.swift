//

import Dependencies
import Foundation


// MARK: - Dependency registration

extension LoginClient: DependencyKey {
    
    public static var liveValue: LoginClient {
        let service = LoginService(defaults: .standard)
        return .init(
            savedCredentials: .property(service, keyPath: \.savedCredentials),
            purgeCredentialsIfNeeded: service.purgeCredentialsIfNeeded
        )
    }
}

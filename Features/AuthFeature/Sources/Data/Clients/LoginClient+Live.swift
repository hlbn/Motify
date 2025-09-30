//

import Foundation


extension LoginClient {
    
    static var live: Self {
        let service = LoginService(defaults: .standard)
        return .init(
            savedCredentials: .property(service, keyPath: \.savedCredentials),
            purgeCredentialsIfNeeded: service.purgeCredentialsIfNeeded
        )
    }
}

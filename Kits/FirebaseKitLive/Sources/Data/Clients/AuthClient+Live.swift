//

import Foundation
import FirebaseKit
import Dependencies


// MARK: - Dependency registration

extension AuthClient: DependencyKey {
    
    public static var liveValue: AuthClient {
        let service = AuthService()
        return .init(
            login: service.login,
            register: service.register,
            logout: service.logout,
            getCurrentUserId: service.getCurrentUserId
        )
    }
}

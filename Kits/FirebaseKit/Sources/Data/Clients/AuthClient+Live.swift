//

import Foundation


public extension AuthClient {
    
    static var live: Self {
        let service = AuthService()
        return .init(
            login: service.login,
            register: service.register,
            logout: service.logout,
            getCurrentUser: service.getCurrentUser
        )
    }
}

//

import Foundation
import UtilityKit
@preconcurrency import KeychainSwift


final class LoginService: Sendable {
    
    // MARK: - Properties
    
    private let defaults: PreconcurrencyUserDefaults
    private let keychain = KeychainSwift()
    
    
    // MARK: - Init
    
    init(defaults: PreconcurrencyUserDefaults) {
        self.defaults = defaults
    }
    
    
    // MARK: - Interface
    
    var savedCredentials: LoginCredentials? {
        get {
            guard
                let username = keychain.get("zyzee.username"),
                let password = keychain.get("zyzee.password")
            else {
                return nil
            }
            
            return .init(username: username, password: password)
        } set {
            if let credentials = newValue {
                keychain.set(credentials.username, forKey: "zyzee.username")
                keychain.set(credentials.password, forKey: "zyzee.password")
            } else {
                keychain.delete("zyzee.username")
                keychain.delete("zyzee.password")
            }
        }
    }
    
    @Sendable
    func purgeCredentialsIfNeeded() {
        if !defaults.bool(forKey: "didRunBefore") {
            keychain.clear()
            defaults.set(true, forKey: "didRunBefore")
        }
    }
}

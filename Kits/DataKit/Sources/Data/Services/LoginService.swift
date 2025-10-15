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
                let email = keychain.get("motify.email"),
                let password = keychain.get("motify.password")
            else {
                return nil
            }
            
            return .init(email: email, password: password)
        } set {
            if let credentials = newValue {
                keychain.set(credentials.email, forKey: "motify.email")
                keychain.set(credentials.password, forKey: "motify.password")
            } else {
                keychain.delete("motify.email")
                keychain.delete("motify.email")
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

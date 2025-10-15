//

import Foundation
import FirebaseAuth


struct AuthService {

    // MARK: - Interface
    
    @Sendable
    func login(username: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: username, password: password)
    }
    
    @Sendable
    func register(username: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: username, password: password)
        // User is automatically signed in, but we dont want that
        try logout()
    }
    
    @Sendable
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    @Sendable
    func getCurrentUserId() -> String? {
        Auth.auth().currentUser?.uid
    }
    
    @Sendable
    func getCurrentUserEmail() -> String? {
        Auth.auth().currentUser?.email
    }
}

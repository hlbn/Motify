//

import Foundation
import FirebaseAuth


final class AuthService {

    // MARK: - Interface
    
    func login(username: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: username, password: password)
    }
    
    func register(username: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: username, password: password)
        // User is automatically signed in, but we dont want that
        try logout()
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func getCurrentUser() -> FirebaseAuth.User? {
        Auth.auth().currentUser
    }
}

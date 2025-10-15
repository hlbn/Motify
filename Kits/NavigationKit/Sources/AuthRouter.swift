//

import Foundation
import SwiftUI


public enum AuthPath {
    case register
}

@MainActor
public final class AuthRouter: ObservableObject {
    
    // MARK: - Properties
    
    @Published public var path = [AuthPath]()
    @Published public var isLoggedIn = false
    @Published public var userId: String?
    
    
    // MARK: - Init
    
    public init() {
    }
    
    
    // MARK: - Interface
    
    public func showRegisterView() {
        path.append(.register)
    }
    
    public func setAuthState(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
    }
    
    public func setCurrentUserId(id: String?) {
        userId = id
    }
}

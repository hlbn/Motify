//

import DesignKit
import FirebaseKit
import Foundation
import NavigationKit
import OSLog
import UIKit
import UtilityKit


struct LoginViewState {
    
    // MARK: - Properties
    
    var email: String = .empty
    var emailError: Localization?
    var password: String = .empty
    
    var alert: AlertVO?
    var isLoading = false
    
    
    // MARK: - Computed properties
    
    var isLoginButtonEnabled: Bool {
        emailError == nil && password.count > 5
    }
}


@MainActor
final class LoginViewModel: ObservableObject {
    
    struct Dependencies {
        let loginClient: LoginClient
        let authClient: AuthClient
    }
    
    
    // MARK: - State

    @Published var state = LoginViewState()


    // MARK: - Services

    private let deps: Dependencies
    
    
    // MARK: - Init

    init(deps: Dependencies) {
        self.deps = deps
        
        setupInitial()
    }
    
    
    // MARK: - Actions
    
    func onLoginTap(router: AuthRouter) async {
        await performLogin(router: router, username: state.email, password: state.password)
    }
    
    func onEmailChange() {
        guard !state.email.isEmpty else {
            state.emailError = nil
            return
        }
        
        state.email = state.email.prefixStr(100)
        state.emailError = Validator.isEmailValid(state.email) ? nil : "email.error".localized
    }
}


// MARK: - Private methods

private extension LoginViewModel {
    
    func setupInitial() {
        deps.loginClient.purgeCredentialsIfNeeded()
        state.email = deps.loginClient.savedCredentials?.username ?? .empty
    }
    
    func performLogin(router: AuthRouter, username: String, password: String) async {
        UIApplication.hideKeyboard()
        
        state.isLoading = true
        
        do {
            try await deps.authClient.login(username, password)
            
            deps.loginClient.savedCredentials = .init(username: username, password: password)
            
            state.password = .empty
            
            router.setAuthState(isLoggedIn: true)
        } catch {
            state.alert = .init(title: "login.auth.error".localized)
        }
        
        state.isLoading = false
    }
}

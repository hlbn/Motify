//

import DesignKit
import FirebaseKit
import Foundation
import NavigationKit
import OSLog
import UIKit
import Dependencies
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
    
    // MARK: - State

    @Published var state = LoginViewState()


    // MARK: - Services

    @Dependency(LoginClient.self) private var loginClient
    @Dependency(AuthClient.self) private var authClient
    
    
    // MARK: - Init

    init() {
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
        loginClient.purgeCredentialsIfNeeded()
        state.email = loginClient.savedCredentials?.username ?? .empty
    }
    
    func performLogin(router: AuthRouter, username: String, password: String) async {
        UIApplication.hideKeyboard()
        
        state.isLoading = true
        
        do {
            try await authClient.login(username, password)
            
            loginClient.savedCredentials = .init(username: username, password: password)
            
            state.password = .empty
            
            router.setAuthState(isLoggedIn: true)
        } catch {
            state.alert = .init(title: "login.auth.error".localized)
        }
        
        state.isLoading = false
    }
}

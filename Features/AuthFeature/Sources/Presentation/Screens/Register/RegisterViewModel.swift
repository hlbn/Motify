//

import DesignKit
import FirebaseKit
import Foundation
import SwiftUI
import UtilityKit


struct RegisterViewState {
    
    // MARK: - Properties
    
    var email: String = .empty
    var emailError: Localization?
    var password: String = .empty
    var passwordError: Localization?
    var repeatedPassword: String = .empty
    var repeatedPasswordError: Localization?
    
    var alert: AlertVO?
    var isLoading = false
    
    
    // MARK: - Computed properties
    
    var isRegisterBttonEnabled: Bool {
        if email.isEmpty || password.isEmpty || repeatedPassword.isEmpty {
            return false
        }
        
        return emailError == nil && passwordError == nil && repeatedPasswordError == nil
    }
}

@MainActor
final class RegisterViewModel: ObservableObject {
    
    struct Dependencies {
        let authClient: AuthClient
    }
    
    
    // MARK: - State

    @Published var state = RegisterViewState()


    // MARK: - Services

    private let deps: Dependencies


    // MARK: - Init

    init(
        deps: Dependencies
    ) {
        self.deps = deps
    }
    
    
    // MARK: - Actions
    
    func onRegisterTap(dismissAction: DismissAction) async {
        state.isLoading = true
        
        do {
            try await deps.authClient.register(state.email, state.password)
            
            state.alert = .init(
                title: "register.successful.title".localized,
                message: "register.successful.message".localized,
                buttons: [
                    .default {
                        dismissAction()
                    }
                ]
            )
        } catch {
            state.alert = .init(title: "register.auth.error".localized)
        }
        
        state.isLoading = false
    }
    
    func onEmailChange() {
        guard !state.email.isEmpty else {
            state.emailError = nil
            return
        }
        
        state.email = state.email.prefixStr(100)
        state.emailError = Validator.isEmailValid(state.email) ? nil : "email.error".localized
    }
    
    func onPasswordChange() {
        state.passwordError = state.password.count > 5 ? nil : "password.error.length".localized
        onRepeatedPasswordChange()
    }
    
    func onRepeatedPasswordChange() {
        state.repeatedPasswordError = state.password == state.repeatedPassword ? nil : "password.notmatching".localized
    }
}


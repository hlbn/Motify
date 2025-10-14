//

import DesignKit
import NavigationKit
import SwiftUI


struct LoginView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: LoginViewModel
    @EnvironmentObject private var router: AuthRouter
    
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                
                VStack(spacing: 8) {
                    Text("login.title".localized.translation)
                        .font(.title, color: .contentMain)
                    
                    Text("login.subtitle".localized.translation)
                        .font(.subheadline, color: .contentMain)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
                
                VStack(spacing: 16) {
                    UnderlinedTextField(
                        "email".localized,
                        text: $viewModel.state.email,
                        keyboardType: .emailAddress,
                        error: viewModel.state.emailError
                    )
                    .onChange(of: viewModel.state.email) { _, _ in
                        viewModel.onEmailChange()
                    }
                    
                    UnderlinedTextField(
                        "password".localized,
                        text: $viewModel.state.password,
                        isSecure: true
                    )
                    .submitLabel(.done)
                    
                    Button("login".localized.translation) {
                        Task {
                            await viewModel.onLoginTap(router: router)
                        }
                    }
                    .padding(.top, 8)
                    .disabled(!viewModel.state.isLoginButtonEnabled)
                    
                    Button("register".localized.translation) {
                        router.showRegisterView()
                    }
                }
                .padding(.horizontal, 24)
                .animation(.easeIn, value: viewModel.state.emailError)
            }
        }
        .background(Color.backgroundMain)
        .navigationBarHidden(true)
        .alert($viewModel.state.alert)
        .loading(viewModel.state.isLoading)
        .task {
            await viewModel.task(router: router)
        }
    }
    
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
}


// MARK: - Preview

#Preview("LoginView") {
    LoginView(
        viewModel: .init()
    )
    .environmentObject(AuthRouter())
}

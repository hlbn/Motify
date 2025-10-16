//

import SwiftUI
import DesignKit


struct RegisterView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: RegisterViewModel
    
    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss
    
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(.logo)
                    .resizable()
                    .frame(size: 160)
                
                VStack(spacing: 8) {
                    Text("register.title".localized.translation)
                        .font(.largeTitle, color: .contentMain)
                    
                    Text("register.subtitle".localized.translation)
                        .font(.subheadline, color: .contentMain)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
                
                VStack(spacing: 24) {
                    UnderlinedTextField(
                        "email".localized,
                        text: $viewModel.state.email,
                        keyboardType: .emailAddress,
                        error: viewModel.state.emailError,
                        hint: "email.hint".localized
                    )
                    .onChange(of: viewModel.state.email) { _, _ in
                        viewModel.onEmailChange()
                    }
                    
                    UnderlinedTextField(
                        "password".localized,
                        text: $viewModel.state.password,
                        error: viewModel.state.passwordError,
                        isSecure: true
                    )
                    .onChange(of: viewModel.state.password) { _, _ in
                        viewModel.onPasswordChange()
                    }
                    
                    UnderlinedTextField(
                        "repeat.password".localized,
                        text: $viewModel.state.repeatedPassword,
                        error: viewModel.state.repeatedPasswordError,
                        isSecure: true
                    )
                    .submitLabel(.done)
                    .onChange(of: viewModel.state.repeatedPassword) { _, _ in
                        viewModel.onRepeatedPasswordChange()
                    }
                    
                    PrimaryButton("register".localized) {
                        Task {
                            await viewModel.onRegisterTap(dismissAction: dismiss)
                        }
                    }
                    .padding(.top, 8)
                    .disabled(!viewModel.state.isRegisterBttonEnabled)
                }
                .padding(.horizontal, 24)
            }
        }
        .animation(.easeIn, value: viewModel.state.emailError)
        .animation(.easeIn, value: viewModel.state.passwordError)
        .animation(.easeIn, value: viewModel.state.repeatedPasswordError)
        .background(Color.backgroundMain)
        .navigationBarHidden(viewModel.state.isLoading)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("register.screen.title".localized)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.backgroundMain, for: .navigationBar)
        .alert($viewModel.state.alert)
        .loading(viewModel.state.isLoading)
    }
    
    
    // MARK: - Init
    
    init(viewModel: RegisterViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
}


// MARK: - Preview

#Preview("RegisterView") {
    RegisterView(
        viewModel: .init()
    )
    .inNavigationView()
}

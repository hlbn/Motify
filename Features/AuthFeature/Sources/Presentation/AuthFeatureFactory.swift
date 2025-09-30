//

import Foundation
import SwiftUI


@MainActor
public enum AuthFeatureFactory {
    
    public static func createLoginView() -> some View {
        let viewModel = LoginViewModel(
            deps: .init(loginClient: .live, authClient: .live)
        )
        
        return LoginView(viewModel: viewModel)
    }
    
    public static func createRegisterView() -> some View {
        let viewModel = RegisterViewModel(
            deps: .init(authClient: .live)
        )
        
        return RegisterView(viewModel: viewModel)
    }
}

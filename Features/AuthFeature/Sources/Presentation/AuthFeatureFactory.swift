//

import Foundation
import SwiftUI


@MainActor
public enum AuthFeatureFactory {
    
    public static func createLoginView() -> some View {
        let viewModel = LoginViewModel()
        return LoginView(viewModel: viewModel)
    }
    
    public static func createRegisterView() -> some View {
        let viewModel = RegisterViewModel()
        return RegisterView(viewModel: viewModel)
    }
}

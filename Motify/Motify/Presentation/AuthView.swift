//

import SwiftUI
import UtilityKit
import AuthFeature
import NavigationKit
import DesignKit


struct AuthView: View {
    
    // MARK: - Properties
    
    @StateObject private var authRouter = AuthRouter()
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack(path: $authRouter.path) {
            AuthFeatureFactory.createLoginView()
                .navigationDestination(for: AuthPath.self) { path in
                    switch path {
                    case .register:
                        AuthFeatureFactory.createRegisterView()
                    }
                }
        }
        .fullScreenCover(isPresented: $authRouter.isLoggedIn) {
            MainView()
        }
        .tint(.mainGreen)
        .environmentObject(authRouter)
    }
}


// MARK: - Preview

#Preview("AuthView") {
    AuthView()
}

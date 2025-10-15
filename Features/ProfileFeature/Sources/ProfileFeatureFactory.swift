//

import Foundation
import SwiftUI


@MainActor
public enum ProfileFeatureFactory {
    
    public static func createProfileView() -> some View {
        let viewModel = ProfileViewModel()
        return ProfileView(viewModel: viewModel)
    }
}

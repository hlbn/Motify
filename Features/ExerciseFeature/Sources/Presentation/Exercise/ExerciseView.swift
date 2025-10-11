//

import DesignKit
import NavigationKit
import SwiftUI
import UtilityKit


struct ExerciseView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: ExerciseViewModel
    @EnvironmentObject private var router: ExerciseRouter
    
    
    // MARK: - Environment
    
    @Environment(\.dismiss) var dismiss
    
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
        }
        .background(Color.bgMain)
        .navigationTitle("exercise.title".localized.translation)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.bgMain, for: .navigationBar)
        .alert($viewModel.state.alert)
        .loading(viewModel.state.isLoading)
    }
    
    
    // MARK: - Init
    
    init(viewModel: ExerciseViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
}


// MARK: - Preview

#Preview("ExerciseView") {
    ExerciseView(
        viewModel: .init(
            input: .init(exerciseEntity: nil),
            deps: .init(
                exerciseClient: .preview,
                authClient: .preview
            )
        )
    )
    .inNavigationView()
    .environmentObject(ExerciseRouter())
}


//

import FirebaseKit
import Foundation
import SwiftUI
import UtilityKit


@MainActor
public enum ExerciseFeatureFactory {
    
    public static func createExerciseListView() -> some View {
        let viewModel = ExerciseListViewModel(
            deps: .init(exerciseClient: .live)
        )
        
        return ExerciseListView(viewModel: viewModel)
    }
    
    public static func createExerciseView(exercise: ExerciseEntity?) -> some View {
        let viewModel = ExerciseViewModel(
            input: .init(exerciseEntity: exercise),
            deps: .init(exerciseClient: .live, authClient: .live)
        )
        
        return ExerciseView(viewModel: viewModel)
    }
}

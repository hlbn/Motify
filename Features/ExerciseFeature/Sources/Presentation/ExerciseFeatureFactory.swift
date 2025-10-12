//

import DesignKit
import Foundation
import SwiftUI
import UtilityKit


@MainActor
public enum ExerciseFeatureFactory {
    
    public static func createExerciseListView() -> some View {
        let viewModel = ExerciseListViewModel()
        return ExerciseListView(viewModel: viewModel)
    }
    
    public static func createExerciseView(exercise: ExerciseVO?) -> some View {
        let viewModel = ExerciseViewModel(input: .init(exerciseVO: exercise))
        return ExerciseView(viewModel: viewModel)
    }
}

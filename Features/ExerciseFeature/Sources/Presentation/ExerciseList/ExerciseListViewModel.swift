//

import DesignKit
import FirebaseKit
import Foundation
import NavigationKit
import Dependencies
import OSLog
import UtilityKit


struct ExerciseListViewState {
    
    // MARK: - Properties
    
    var exercisesVO = [ExerciseVO]()
    
    var isInErrorState = false
    var isLoading = false
    
    
    // MARK: - Computed properties
    
    var showEmptyPlaceholder: Bool {
        exercisesVO.isEmpty && !isLoading
    }
}


@MainActor
final class ExerciseListViewModel: ObservableObject {
    
    // MARK: - State

    @Published var state = ExerciseListViewState()


    // MARK: - Services

    @Dependency(ExerciseClient.self) private var exerciseClient
    
    
    // MARK: - Actions
    
    func task() async {
        state.isLoading = true
        
        do {
            let exercises = try await exerciseClient.fetchExercises()
            
            state.isInErrorState = false
            state.exercisesVO = exercises
        } catch {
            state.isInErrorState = true
            Logger.main.error("Failed to load exercises")
        }
        
        state.isLoading = false
    }
    
    func onWorkoutTap(exercise: ExerciseVO, router: ExerciseRouter) {
        router.showExerciseEdit(exercise: exercise)
    }
    
    func onCreateTap(router: ExerciseRouter) {
        router.showExerciseCreate()
    }
    
    func onExerciseDelete(exercise: ExerciseVO) {
        guard let exerciseId = exercise.id else {
            return
        }
        
        do {
            try exerciseClient.deleteExercise(exerciseId)
            state.exercisesVO.removeAll { $0.id == exerciseId }
        } catch {
            Logger.main.error("Failed to delete exercise")
        }
    }
}

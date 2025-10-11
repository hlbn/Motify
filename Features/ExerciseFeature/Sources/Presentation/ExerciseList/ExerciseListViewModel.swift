//

import DesignKit
import FirebaseKit
import Foundation
import NavigationKit
import UtilityKit


struct ExerciseListViewState {
    
    // MARK: - Properties
    
    fileprivate var exercises = [ExerciseEntity]()
    var exerciseVOs = [ExerciseVO]()
    
    var isInErrorState = false
    var isLoading = false
    
    
    // MARK: - Computed properties
    
    var showEmptyPlaceholder: Bool {
        exerciseVOs.isEmpty && !isLoading
    }
}

@MainActor
final class ExerciseListViewModel: ObservableObject {
    
    struct Dependencies {
        var exerciseClient: ExerciseClient
    }
    
    
    // MARK: - State

    @Published var state = ExerciseListViewState()


    // MARK: - Services

    private let deps: Dependencies


    // MARK: - Init

    init(
        deps: Dependencies
    ) {
        self.deps = deps
    }
    
    
    // MARK: - Actions
    
    func task() async {
        state.isLoading = true
        
        do {
            let exercises = try await deps.exerciseClient.fetchExercises()
            
            state.isInErrorState = false
            state.exercises = exercises
            state.exerciseVOs = ExerciseVOMapper.map(exercises)
        } catch {
            state.isInErrorState = true
        }
        
        state.isLoading = false
    }
    
    func onWorkoutTap(exercise: ExerciseVO, router: ExerciseRouter) {
        guard let exerciseEntity = state.exercises.first(where: { $0.id == exercise.id }) else {
            return
        }
        
        router.showExerciseDetail(exercise: exerciseEntity)
    }
    
    func onCreateTap(router: ExerciseRouter) {
        router.showExerciseCreate()
    }
}

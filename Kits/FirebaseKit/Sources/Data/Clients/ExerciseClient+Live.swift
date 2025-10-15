//

import Foundation
import Dependencies
import DataKit


// MARK: - Dependency registration

extension ExerciseClient: DependencyKey {
    
    public static var liveValue: ExerciseClient {
        let exerciseService = ExerciseService()
        return .init(
            fetchExercises: exerciseService.fetchExercises,
            saveExercise: exerciseService.saveExercise,
            deleteExercise: exerciseService.deleteExercise
        )
    }
}

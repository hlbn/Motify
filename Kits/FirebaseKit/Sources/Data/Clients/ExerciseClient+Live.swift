//

import Foundation


public extension ExerciseClient {
    
    static var live: Self {
        let exerciseService = ExerciseService(authClient: .live)
        
        return .init(
            fetchExercises: exerciseService.fetchExercises,
            addExercise: exerciseService.addExercise,
            saveExercise: exerciseService.saveExercise,
            deleteExercise: exerciseService.deleteExercise
        )
    }
}

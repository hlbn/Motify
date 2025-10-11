//

import Foundation
import FirebaseKit


enum ExerciseEntityMapper {
    
    static func map(_ exercise: ExerciseVO) -> ExerciseEntity {
        ExerciseEntity(
            title: exercise.title.trimmingCharacters(in: .whitespacesAndNewlines),
            description: exercise.description.trimmingCharacters(in: .whitespacesAndNewlines),
            durationMinutes: exercise.durationMinutes
        )
    }
}

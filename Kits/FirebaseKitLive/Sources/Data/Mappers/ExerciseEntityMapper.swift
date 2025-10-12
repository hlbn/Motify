//

import Foundation
import DesignKit


enum ExerciseEntityMapper {
    
    static func map(_ exercise: ExerciseVO) -> ExerciseEntity {
        ExerciseEntity(
            title: exercise.exercise.rawValue,
            description: exercise.description.trimmingCharacters(in: .whitespacesAndNewlines),
            durationMinutes: exercise.durationMinutes.rawValue,
            locationName: exercise.locationName ?? ""
        )
    }
}

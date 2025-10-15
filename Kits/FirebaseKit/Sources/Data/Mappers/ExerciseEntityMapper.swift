//

import Foundation
import DesignKit


enum ExerciseEntityMapper {
    
    static func map(_ exercise: ExerciseVO) -> ExerciseEntity {
        ExerciseEntity(
            title: exercise.exercise.rawValue,
            description: exercise.description.trimmingCharacters(in: .whitespacesAndNewlines),
            durationMinutes: exercise.durationMinutes,
            locationName: exercise.locationName ?? "",
            createdAt: exercise.createdAt
        )
    }
}

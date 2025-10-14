//

import SwiftUI
import SwiftData


@Model
public class LocalExerciseItem {
    @Attribute(.unique) public var id: String
    public var title: String
    public var exerciseDescription: String
    public var durationMinutes: Int
    public var locationName: String?
    public var createdAt: Date
    
    public init(
        id: String,
        title: String,
        exerciseDescription: String,
        durationMinutes: Int,
        locationName: String?,
        createdAt: Date
    ) {
        self.id = id
        self.title = title
        self.exerciseDescription = exerciseDescription
        self.durationMinutes = durationMinutes
        self.locationName = locationName
        self.createdAt = createdAt
    }
    
    public init(from exerciseVO: ExerciseVO) {
        self.id = exerciseVO.id ?? UUID().uuidString
        self.title = exerciseVO.exercise.rawValue
        self.exerciseDescription = exerciseVO.description
        self.durationMinutes = exerciseVO.durationMinutes
        self.locationName = exerciseVO.locationName
        self.createdAt = exerciseVO.createdAt
    }
}

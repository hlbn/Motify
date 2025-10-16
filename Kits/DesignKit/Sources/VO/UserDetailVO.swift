//

import Foundation


public struct UserDetailVO {
    
    // MARK: - Properties
    
    public var favoriteExercise: String?
    public var totalTrainings: Int?
    public var totalMinutesOfTraining: Int?
    
    
    // MARK: - Init
    
    public init(favoriteExercise: String?, totalTrainings: Int?, totalMinutesOfTraining: Int?) {
        self.favoriteExercise = favoriteExercise
        self.totalTrainings = totalTrainings
        self.totalMinutesOfTraining = totalMinutesOfTraining
    }
}


// MARK: - Preview

public extension UserDetailVO {
    
    static var preview: Self {
        .init(
            favoriteExercise: "run",
            totalTrainings: 3,
            totalMinutesOfTraining: 180
        )
    }
}

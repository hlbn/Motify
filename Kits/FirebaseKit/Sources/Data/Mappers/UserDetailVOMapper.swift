//

import Foundation
import DesignKit

enum UserDetailVOMapper {
    
    static func map(_ entity: UserDetailEntity) -> UserDetailVO {
        UserDetailVO(
            favoriteExercise: entity.favoriteExercise,
            totalTrainings: entity.totalTrainings,
            totalMinutesOfTraining: entity.totalMinutesOfTraining
        )
    }
}

//

import Foundation
import DesignKit


enum ExerciseVOMapper {
    
    static func map(_ entities: [ExerciseEntity]) -> [ExerciseVO] {
        entities.compactMap(Self.map)
    }
    
    static func map(_ entity: ExerciseEntity) -> ExerciseVO? {
        guard let entityId = entity.id else {
            return nil
        }
        
        return .init(
            id: entityId,
            exercise: .init(rawValue: entity.title) ?? .none,
            description: entity.description,
            durationMinutes: entity.durationMinutes,
            storageType: .remote,
            locationName: entity.locationName
        )
    }
}

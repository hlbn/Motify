//

import SwiftUI
import UtilityKit


public struct ExerciseVO: Identifiable, Equatable, Hashable {
    
    public enum StorageType {
        case local
        case remote
    }
    
    // MARK: - Properties
    
    public let id: String?
    public var title: String
    public var description: String
    public var durationMinutes: Int
    public var storageType: StorageType
    
    
    // MARK: - Init
    
    public init(id: String?, title: String, description: String, durationMinutes: Int, storageType: StorageType) {
        self.id = id
        self.title = title
        self.description = description
        self.durationMinutes = durationMinutes
        self.storageType = storageType
    }
}


// MARK: - Convenience

public extension ExerciseVO {
    
    static var empty: Self {
        .init(
            id: nil,
            title: "",
            description: "",
            durationMinutes: 0,
            storageType: .local
        )
    }
}


// MARK: - Preview

public extension [ExerciseVO] {
    
    static var preview: Self {
        [
            .init(
                id: "initial_2",
                title: "Exercise preview",
                description: "Preview description",
                durationMinutes: 60,
                storageType: .local
            ),
            .init(
                id: "initial",
                title: "Exercise preview 2",
                description: "Preview description",
                durationMinutes: 30,
                storageType: .remote
            )
        ]
    }
}

public extension ExerciseVO {
    
    static var preview: Self {
        .init(
            id: "initial",
            title: "Chest workout",
            description: "Intensive chest pump workout",
            durationMinutes: 45,
            storageType: .remote
        )
    }
}

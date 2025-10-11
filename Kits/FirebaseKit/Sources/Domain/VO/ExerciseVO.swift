//

import Foundation
import SwiftUI
import UtilityKit


public struct ExerciseVO: Identifiable, Equatable, Hashable {
    
    // MARK: - Properties
    
    public let id: String?
    public var title: String
    public var description: String
    public var durationMinutes: Int
    
    
    // MARK: - Init
    
    public init(id: String?, title: String, description: String, durationMinutes: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.durationMinutes = durationMinutes
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
                durationMinutes: 60
            ),
            .init(
                id: "initial",
                title: "Exercise preview 2",
                description: "Preview description",
                durationMinutes: 30
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
            durationMinutes: 45
        )
    }
}

//

import DesignKit
import Foundation
import SwiftUI
import UtilityKit


struct ExerciseVO: Identifiable, Equatable {
    
    // MARK: - Properties
    
    let id: String?
    var title: String
    var description: String
    var durationMinutes: Int
}


// MARK: - Convenience

extension ExerciseVO {
    
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

extension ExerciseVO {
    
    static var preview: Self {
        .init(
            id: "initial",
            title: "Chest workout",
            description: "Intensive chest pump workout",
            durationMinutes: 45
        )
    }
}

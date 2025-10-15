//

import SwiftUI
import UtilityKit


public struct ExerciseVO: Identifiable, Equatable, Hashable {
    
    public enum StorageType: String {
        case local
        case remote
    }
    
    public enum Exercise: String, CaseIterable, Comparable {
        case weightlift
        case run
        case walk
        case pilates
        case yoga
        case box
        case none
        
        public var localized: Localization {
            switch self {
            case .weightlift:
                "exercise.weightlift".localized
            case .run:
                "exercise.run".localized
            case .walk:
                "exercise.walk".localized
            case .pilates:
                "exercise.pilates".localized
            case .yoga:
                "exercise.yoga".localized
            case .box:
                "exercise.box".localized
            case .none:
                "exercise.none".localized
            }
        }
        
        public var icon: Image {
            switch self {
            case .weightlift:
                Image(systemName: "figure.strengthtraining.traditional.circle.fill")
            case .run:
                Image(systemName: "figure.run.circle.fill")
            case .walk:
                Image(systemName: "figure.walk.circle.fill")
            case .pilates:
                Image(systemName: "figure.pilates.circle.fill")
            case .yoga:
                Image(systemName: "figure.yoga.circle.fill")
            case .box:
                Image(systemName: "figure.boxing.circle.fill")
            case .none:
                Image(systemName: "pencil.circle.fill")
            }
        }
        
        public static func < (lhs: ExerciseVO.Exercise, rhs: ExerciseVO.Exercise) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
    
    
    // MARK: - Properties
    
    public let id: String?
    public var exercise: Exercise
    public var description: String
    public var durationMinutes: Int
    public var storageType: StorageType
    public var locationName: String?
    public var createdAt: Date
    
    
    // MARK: - Init
    
    public init(
        id: String?,
        exercise: Exercise,
        description: String,
        durationMinutes: Int,
        storageType: StorageType,
        locationName: String?,
        createdAt: Date
    ) {
        self.id = id
        self.exercise = exercise
        self.description = description
        self.durationMinutes = durationMinutes
        self.storageType = storageType
        self.locationName = locationName
        self.createdAt = createdAt
    }
}


// MARK: - Convenience

public extension ExerciseVO {
    
    static var empty: Self {
        .init(
            id: nil,
            exercise: .none,
            description: "",
            durationMinutes: 0,
            storageType: .local,
            locationName: nil,
            createdAt: Date.now
        )
    }
}


// MARK: - Preview

public extension [ExerciseVO] {
    
    static var preview: Self {
        [
            .init(
                id: "initial_2",
                exercise: .walk,
                description: "Preview description",
                durationMinutes: 0,
                storageType: .local,
                locationName: "Americká",
                createdAt: Date.now.addingTimeInterval(-2600)
            ),
            .init(
                id: "initial",
                exercise: .run,
                description: "Preview description",
                durationMinutes: 0,
                storageType: .remote,
                locationName: "Americká",
                createdAt: Date.now.addingTimeInterval(-3600)
            )
        ]
    }
}

public extension ExerciseVO {
    
    static var preview: Self {
        .init(
            id: "initial",
            exercise: .weightlift,
            description: "Intensive chest pump workout",
            durationMinutes: 0,
            storageType: .remote,
            locationName: "Americká",
            createdAt: Date.now.addingTimeInterval(-2600)
        )
    }
}

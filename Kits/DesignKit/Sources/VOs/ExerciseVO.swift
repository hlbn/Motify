//

import SwiftUI
import MapKit
import UtilityKit


public struct ExerciseVO: Identifiable, Equatable, Hashable {
    
    public enum StorageType {
        case local
        case remote
    }
    
    public enum Exercise: String, CaseIterable {
        case weightlift = "exercise.weightlift"
        case run = "exercise.run"
        case walk = "exercise.walk"
        case pilates = "exercise.pilates"
        case yoga = "exercise.yoga"
        case box = "exercise.box"
        case none
        
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
    }
    
    public enum DurationMinutes: Int, CaseIterable {
        case none = 0
        case five = 5
        case ten = 10
        case fifteen = 15
        case twenty = 20
        case twentyFive = 25
        case thirty = 30
        case thirtyFive = 35
        case forty = 40
        case fortyFive = 45
        case fifty = 50
        case fiftyFive = 55
        case sixty = 60
        case sixtyFive = 65
        case seventy = 70
        case seventyFive = 75
        case eighty = 80
        case eightyFive = 85
        case ninety = 90
        case ninetyFive = 95
        case oneHundred = 100
        case oneHundredFive = 105
        case oneHundredTen = 110
        case oneHundredFifteen = 115
        case oneHundredTwenty = 120
    }
    
    
    // MARK: - Properties
    
    public let id: String?
    public var exercise: Exercise
    public var description: String
    public var durationMinutes: DurationMinutes
    public var storageType: StorageType
    public var locationName: String?
    
    
    // MARK: - Init
    
    public init(
        id: String?,
        exercise: Exercise,
        description: String,
        durationMinutes: DurationMinutes,
        storageType: StorageType,
        locationName: String?
    ) {
        self.id = id
        self.exercise = exercise
        self.description = description
        self.durationMinutes = durationMinutes
        self.storageType = storageType
        self.locationName = locationName
    }
}


// MARK: - Convenience

public extension ExerciseVO {
    
    static var empty: Self {
        .init(
            id: nil,
            exercise: .none,
            description: "",
            durationMinutes: .none,
            storageType: .local,
            locationName: nil
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
                durationMinutes: .sixty,
                storageType: .local,
                locationName: "Americká"
            ),
            .init(
                id: "initial",
                exercise: .run,
                description: "Preview description",
                durationMinutes: .thirty,
                storageType: .remote,
                locationName: "Americká"
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
            durationMinutes: .fortyFive,
            storageType: .remote,
            locationName: "Americká"
        )
    }
}

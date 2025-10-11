//


import FirebaseKit
import Foundation
import SwiftUI


public enum ExercisePath: Hashable {
    case exercise(ExerciseEntity?)
    case exerciseDetail(ExerciseEntity)
}

@MainActor
public final class ExerciseRouter: ObservableObject {
    
    // MARK: - Properties
    
    @Published public var path = [ExercisePath]()
    
    
    // MARK: - Init
    
    public init() { }
    
    
    // MARK: - Interface
    
    public func showExerciseDetail(exercise: ExerciseEntity) {
        path.append(.exerciseDetail(exercise))
    }
    
    public func showExerciseCreate() {
        path.append(.exercise(nil))
    }
    
    public func showExerciseEdit(exercise: ExerciseEntity) {
        path.append(.exercise(exercise))
    }
}

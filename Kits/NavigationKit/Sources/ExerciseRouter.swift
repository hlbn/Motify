//


import DesignKit
import Foundation
import SwiftUI


public enum ExercisePath: Hashable {
    case exercise(ExerciseVO?)
    case exerciseDetail(ExerciseVO)
}

@MainActor
public final class ExerciseRouter: ObservableObject {
    
    // MARK: - Properties
    
    @Published public var path = [ExercisePath]()
    
    
    // MARK: - Init
    
    public init() { }
    
    
    // MARK: - Interface
    
    public func showExerciseDetail(exercise: ExerciseVO) {
        path.append(.exerciseDetail(exercise))
    }
    
    public func showExerciseCreate() {
        path.append(.exercise(nil))
    }
    
    public func showExerciseEdit(exercise: ExerciseVO) {
        path.append(.exercise(exercise))
    }
}

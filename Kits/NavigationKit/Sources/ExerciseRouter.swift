//


import DesignKit
import Foundation
import SwiftUI


public enum ExercisePath: Hashable {
    case exerciseCreate
    case exerciseEdit(ExerciseVO)
}

@MainActor
public final class ExerciseRouter: ObservableObject {
    
    // MARK: - Properties
    
    @Published public var path = [ExercisePath]()
    
    
    // MARK: - Init
    
    public init() { }
    
    
    // MARK: - Interface
    
    public func showExerciseCreate() {
        path.append(.exerciseCreate)
    }
    
    public func showExerciseEdit(exercise: ExerciseVO) {
        path.append(.exerciseEdit(exercise))
    }
}

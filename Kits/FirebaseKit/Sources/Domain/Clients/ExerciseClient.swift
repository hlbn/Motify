//

import Foundation


public struct ExerciseClient {
    public var fetchExercises: () async throws -> [ExerciseEntity]
    public var addExercise: (ExerciseEntity) throws -> Void
    public var saveExercise: (ExerciseEntity, _ id: String) async throws -> Void
    public var deleteExercise: (String, Bool) async throws -> Void
}


// MARK: - Preview

public extension ExerciseClient {
    
    static var preview: Self {
        .init(
            fetchExercises: { .preview },
            addExercise: { _ in },
            saveExercise: { _, _ in },
            deleteExercise: { _, _ in }
        )
    }
}

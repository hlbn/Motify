//

import Foundation


public struct ExerciseClient {
    public var fetchExercises: () async throws -> [ExerciseEntity]
    public var saveExercise: (ExerciseEntity, _ id: String?) throws -> Void
    public var deleteExercise: (String) throws -> Void
}


// MARK: - Preview

public extension ExerciseClient {
    
    static var preview: Self {
        .init(
            fetchExercises: { .preview },
            saveExercise: { _, _ in },
            deleteExercise: { _ in }
        )
    }
}

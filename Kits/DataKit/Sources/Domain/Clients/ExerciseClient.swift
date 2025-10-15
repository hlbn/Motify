//

import Foundation
import DesignKit
import Dependencies


public struct ExerciseClient: Sendable {
    public var fetchExercises: @Sendable () async throws -> [ExerciseVO]
    public var saveExercise: @Sendable (ExerciseVO, _ id: String?) throws -> Void
    public var deleteExercise: @Sendable (String) throws -> Void
    
    public init(
        fetchExercises: @Sendable @escaping () async throws -> [ExerciseVO],
        saveExercise: @Sendable @escaping (ExerciseVO, _: String?) throws -> Void,
        deleteExercise: @Sendable @escaping (String) throws -> Void
    ) {
        self.fetchExercises = fetchExercises
        self.saveExercise = saveExercise
        self.deleteExercise = deleteExercise
    }
}


// MARK: - Preview

extension ExerciseClient: TestDependencyKey {
    
    public static var previewValue: ExerciseClient { testValue }
    public static var testValue: ExerciseClient {
        ExerciseClient(
            fetchExercises: { .preview },
            saveExercise: { _, _ in },
            deleteExercise: { _ in }
        )
    }
}

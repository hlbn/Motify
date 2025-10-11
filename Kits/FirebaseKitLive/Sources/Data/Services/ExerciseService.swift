//

@preconcurrency import FirebaseFirestore
import Foundation
import FirebaseKit
import Dependencies
import UtilityKit


struct ExerciseService {
    
    // MARK: - Properties
    
    private let firestore = Firestore.firestore()
    @Dependency(AuthClient.self) private var authClient
    
    
    // MARK: - Interfcae
    
    @Sendable
    func fetchExercises() async throws -> [ExerciseVO] {
        guard let userId = authClient.getCurrentUserId() else {
            throw DataError.failed("fetchExercises -> Missing user id")
        }
        
        let exercisesRef = firestore.collection("users").document(userId).collection("exercises")
        
        let exercises = try await exercisesRef.getDocuments(as: ExerciseEntity.self)
        return ExerciseVOMapper.map(exercises)
    }
    
    @Sendable
    func saveExercise(exercise: ExerciseVO, workoutId: String?) throws {
        guard let userId = authClient.getCurrentUserId() else {
            throw DataError.failed("saveExercise -> Missing user id")
        }
        
        let exerciseEntity = ExerciseEntityMapper.map(exercise)
        
        let exercisesRef = if let workoutId {
            firestore.collection("users").document(userId).collection("exercises").document(workoutId)
        } else {
            firestore.collection("users").document(userId).collection("exercises").document()
        }
        
        try exercisesRef.setData(from: exerciseEntity)
    }
    
    @Sendable
    func deleteExercise(exerciseId: String) throws {
        guard let userId = authClient.getCurrentUserId() else {
            throw DataError.failed("deleteExercise -> Missing user id")
        }
        
        let exercisesRef = firestore.collection("users").document(userId).collection("exercises").document(exerciseId)
        
        exercisesRef.delete()
    }
}

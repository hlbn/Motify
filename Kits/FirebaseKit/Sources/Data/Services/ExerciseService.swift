//

import FirebaseFirestore
import Foundation
import UtilityKit


final class ExerciseService {
    
    // MARK: - Properties
    
    private let firestore = Firestore.firestore()
    private let authClient: AuthClient
    
    
    // MARK: - Init
    
    init(authClient: AuthClient) {
        self.authClient = authClient
    }
    
    
    // MARK: - Interfcae
    
    func fetchExercises() async throws -> [ExerciseEntity] {
        guard let userId = authClient.getCurrentUser()?.uid else {
            throw DataError.failed("fetchExercises -> Missing user id")
        }
        
        let exercisesRef = firestore.collection("users").document(userId).collection("exercises")
        
        return try await exercisesRef.getDocuments(as: ExerciseEntity.self)
    }
    
    func saveExercise(workout: ExerciseEntity, workoutId: String?) throws {
        guard let userId = authClient.getCurrentUser()?.uid else {
            throw DataError.failed("saveExercise -> Missing user id")
        }
        
        let exercisesRef = if let workoutId {
            firestore.collection("users").document(userId).collection("exercises").document(workoutId)
        } else {
            firestore.collection("users").document(userId).collection("exercises").document()
        }
        
        try exercisesRef.setData(from: workout)
    }
    
    func deleteExercise(workoutId: String) throws {
        guard let userId = authClient.getCurrentUser()?.uid else {
            throw DataError.failed("deleteExercise -> Missing user id")
        }
        
        let exercisesRef = firestore.collection("users").document(userId).collection("exercises").document(workoutId)
        
        exercisesRef.delete()
    }
}

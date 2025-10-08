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
    
    func addExercise(workout: ExerciseEntity) throws {
        guard let userId = authClient.getCurrentUser()?.uid else {
            throw DataError.failed("addExercise -> Missing user id")
        }
        
        let exercisesRef = firestore.collection("users").document(userId).collection("exercises").document()
        
        try exercisesRef.setData(from: workout)
    }
    
    func saveExercise(workout: ExerciseEntity, workoutId: String) async throws {
        guard let userId = authClient.getCurrentUser()?.uid else {
            throw DataError.failed("saveExercise -> Missing user id")
        }
        
        let batch = firestore.batch()
        let exercisesRef = firestore.collection("users").document(userId).collection("exercises").document(workoutId)
        
        try batch.setData(from: workout, forDocument: exercisesRef)
        
        try await batch.commit()
    }
    
    func deleteExercise(workoutId: String, shouldDeletePublished: Bool) async throws {
        guard let userId = authClient.getCurrentUser()?.uid else {
            throw DataError.failed("deleteExercise -> Missing user id")
        }
        
        let batch = firestore.batch()
        let exercisesRef = firestore.collection("users").document(userId).collection("exercises").document(workoutId)
        
        batch.deleteDocument(exercisesRef)
        
        try await batch.commit()
    }
}

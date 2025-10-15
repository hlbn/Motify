//

import DataKit
@preconcurrency import FirebaseFirestore
import Dependencies
import DesignKit
import UtilityKit


struct UserDetailService {
    
    // MARK: - Properties
    
    @Dependency(AuthClient.self) private var authClient
    private let firestore = Firestore.firestore()
    
    
    // MARK: - Interface
    
    func getUserDetail() async throws -> UserDetailVO {
        guard let userId = authClient.getCurrentUserId() else {
            throw DataError.failed("getUserDetail -> Missing user id")
        }
        
        let userDetail = try await firestore.collection("users").document(userId).getDocument(as: UserDetailEntity.self)
        return UserDetailVOMapper.map(userDetail)
    }
    
    func updateUserDetail(favoriteExercise: String, totalTrainings: Int, totalMinutes: Int) throws {
        guard let userId = authClient.getCurrentUserId() else {
            throw DataError.failed("updateUserDetail -> Missing user id")
        }
        
        firestore.collection("users").document(userId).setData(
            [
                "favoriteExercise": favoriteExercise,
                "totalTrainings": totalTrainings,
                "totalMinutesOfTraining": totalMinutes
            ],
            merge: true
        )
    }
}

//

import Foundation
import FirebaseFirestore


public extension CollectionReference {
    
    func getDocuments<T: Codable>(as type: T.Type) async throws -> [T] {
        let snapshot = try await self.getDocuments()
        return try snapshot.documents.map { document in
            try document.data(as: T.self)
        }
    }
}

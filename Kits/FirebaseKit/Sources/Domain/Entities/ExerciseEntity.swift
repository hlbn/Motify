// swiftlint:disable function_default_parameter_at_end

import Foundation
import FirebaseFirestore
import UtilityKit


public struct ExerciseEntity: Codable, Hashable {
    
    // MARK: - Properties
    
    @DocumentID public var id: String?
    public let title: String
    public let description: String
    public let durationMinutes: Int
    public var locationName: String?
    public var createdAt: Date
    
    
    // MARK: - Init
    
    public init(
        id: String? = nil,
        title: String,
        description: String,
        durationMinutes: Int,
        locationName: String,
        createdAt: Date
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.durationMinutes = durationMinutes
        self.locationName = locationName
        self.createdAt = createdAt
    }
}

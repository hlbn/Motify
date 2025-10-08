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
    public let location: GeoPoint
    
    
    // MARK: - Init
    
    public init(
        id: String? = nil,
        title: String,
        description: String,
        durationMinutes: Int,
        location: GeoPoint
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.durationMinutes = durationMinutes
        self.location = location
    }
}


// MARK: - Preview data

public extension [ExerciseEntity] {
    
    static var preview: Self {
        [
            .init(
                id: UUID().uuidString,
                title: "Exercise preview",
                description: "Preview description",
                durationMinutes: 60,
                location: .init(latitude: 0, longitude: 0)
            ),
            .init(
                id: UUID().uuidString,
                title: "Exercise preview 2",
                description: "Preview description",
                durationMinutes: 30,
                location: .init(latitude: 0, longitude: 0)
            )
        ]
    }
}


public extension ExerciseEntity {
    
    static var preview: Self {
        .init(
            id: UUID().uuidString,
            title: "Exercise preview",
            description: "Preview description",
            durationMinutes: 60,
            location: .init(latitude: 0, longitude: 0)
        )
    }
}

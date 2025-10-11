//

import Foundation
import SwiftUI


enum Asset {
    
    struct Icon {
        let name: String
        let image: Image
    }
       
    private static let fallbackExerciseIcon = Image(systemName: "dumbbell")
    private static let exerciseIcons: [Icon] = [
        .init(name: "main", image: .init(systemName: "dumbbell")),
        .init(name: "12", image: .init(systemName: "heart.fill")),
        .init(name: "13", image: .init(systemName: "flame.fill")),
        .init(name: "14", image: .init(systemName: "bolt.fill")),
        .init(name: "15", image: .init(systemName: "stopwatch.fill")),
        .init(name: "20", image: .init(systemName: "trophy.fill")),
        .init(name: "0", image: .init(systemName: "figure.walk")),
        .init(name: "3", image: .init(systemName: "figure.run")),
        .init(name: "6", image: .init(systemName: "figure.strengthtraining.traditional")),
        .init(name: "7", image: .init(systemName: "figure.cooldown")),
        .init(name: "8", image: .init(systemName: "figure.yoga")),
        .init(name: "11", image: .init(systemName: "figure.flexibility")),
        .init(name: "21", image: .init(systemName: "figure.stairs")),
        .init(name: "22", image: .init(systemName: "figure.highintensity.intervaltraining")),
        .init(name: "23", image: .init(systemName: "figure.rower"))
    ]
    
    static func getIcon(for name: String) -> Image {
        exerciseIcons.first { $0.name == name }?.image ?? fallbackExerciseIcon
    }
    
    static func getIcons() -> [Icon] {
        exerciseIcons
    }
}

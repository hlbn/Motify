//

import DesignKit
import SwiftUI
import NavigationKit
import ExerciseFeature
import UtilityKit


struct MainView: View {
    
    // MARK: - Properties
    
    @StateObject private var exerciseRouter = ExerciseRouter()
    
    
    // MARK: - Body
    
    var body: some View {
        TabView {
            Group {
                NavigationStack(path: $exerciseRouter.path) {
                    ExerciseFeatureFactory.createExerciseListView()
                        .navigationDestination(for: ExercisePath.self) { path in
                            switch path {
                            case .exerciseCreate:
                                ExerciseFeatureFactory.createExerciseView(exercise: nil)
                            case .exerciseEdit(let exercise):
                                ExerciseFeatureFactory.createExerciseView(exercise: exercise)
                            }
                        }
                }
                .tabItem {
                    Label("tab.dashboard".localized.translation, systemImage: "figure.run")
                }
                .environmentObject(exerciseRouter)
                
            }
        }
        .tint(Color.mainBlue)
    }
}


// MARK: - Preview

#Preview {
    MainView()
}

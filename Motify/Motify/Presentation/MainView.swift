//

import DesignKit
import SwiftUI
import NavigationKit
import ExerciseFeature
import SwiftData
import OSLog
import UtilityKit


struct MainView: View {
    
    // MARK: - Properties
    
    @StateObject private var exerciseRouter = ExerciseRouter()
    var modelContainer: ModelContainer?
    var isLocalStorageDisabled = false
    
    
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
        .ifLet(modelContainer) { view, container in
            view.modelContainer(container)
        }
        .if(isLocalStorageDisabled) {
            $0.environment(\.isLocalStorageDisabled, true)
        }
    }
    
    
    // MARK: - Init
    
    init(userId: String?) {
        do {
            let storeURL = URL.documentsDirectory.appending(path: "\(userId ?? "default").storage")
            let config = ModelConfiguration(url: storeURL)
            modelContainer = try ModelContainer(for: LocalExerciseItem.self, configurations: config)
        } catch {
            Logger.main.error("Failed to create model container")
            isLocalStorageDisabled = true
        }
    }
}


// MARK: - Preview

#Preview {
    MainView(userId: nil)
}

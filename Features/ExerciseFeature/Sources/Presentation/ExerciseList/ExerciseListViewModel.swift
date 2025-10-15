//

import DesignKit
import DataKit
import Foundation
import NavigationKit
import Dependencies
import OSLog
import SwiftUI
import SwiftData
import UtilityKit


struct ExerciseListViewState {
    
    // MARK: - Types definition
    
    enum ExerciseFilter: String, CaseIterable {
        case all
        case local
        case remote
        
        var title: String {
            switch self {
            case .all:
                "exercise.filter.all".localized.translation
            case .local:
                "exercise.filter.local".localized.translation
            case .remote:
                "exercise.filter.remote".localized.translation
            }
        }
    }
    
    
    // MARK: - Properties
    
    fileprivate var localExercises = [LocalExerciseItem]()
    
    var exercisesVO = [ExerciseVO]()
    var localExercisesVO = [ExerciseVO]()
    
    var filter: ExerciseFilter = .all
    var isInErrorState = false
    var isLoading = false
    
    
    // MARK: - Computed properties
    
    var filteredExercises: [ExerciseVO] {
        switch filter {
        case .all:
            return allExercises.sorted { $0.createdAt > $1.createdAt }
        case .local:
            return allExercises.filter { $0.storageType == .local }.sorted { $0.createdAt > $1.createdAt }
        case .remote:
            return allExercises.filter { $0.storageType == .remote }.sorted { $0.createdAt > $1.createdAt }
        }
    }
    
    var allExercises: [ExerciseVO] {
        exercisesVO + localExercisesVO
    }
    
    var showEmptyPlaceholder: Bool {
        exercisesVO.isEmpty && !isLoading
    }
}


@MainActor
final class ExerciseListViewModel: ObservableObject {
    
    // MARK: - State

    @Published var state = ExerciseListViewState()


    // MARK: - Services

    @Dependency(ExerciseClient.self) private var exerciseClient
    @Dependency(UserDetailClient.self) private var userDetailClient
    
    
    // MARK: - Actions
    
    func task(localExercises: [LocalExerciseItem]) async {
        state.isLoading = true
        
        do {
            let exercises = try await exerciseClient.fetchExercises()
            
            state.isInErrorState = false
            state.exercisesVO = exercises
            handleLocalExercises(localExercises: localExercises)
        } catch {
            state.isInErrorState = true
            Logger.main.error("Failed to load exercises")
        }
        
        updateUserDetail()
        state.isLoading = false
    }
    
    func onWorkoutTap(exercise: ExerciseVO, router: ExerciseRouter) {
        router.showExerciseEdit(exercise: exercise)
    }
    
    func onCreateTap(router: ExerciseRouter) {
        router.showExerciseCreate()
    }
    
    func onExerciseDelete(context: ModelContext, exercise: ExerciseVO) {
        guard let exerciseId = exercise.id else {
            return
        }
        
        do {
            switch exercise.storageType {
            case .remote:
                try exerciseClient.deleteExercise(exerciseId)
                state.exercisesVO.removeAll { $0.id == exerciseId }
            case .local:
                guard let item = state.localExercises.first(where: { $0.id == exerciseId }) else {
                    Logger.main.error("Failed to delete exercise, no exercise with id: \(exerciseId) found")
                    return
                }
                
                context.delete(item)
                try context.save()
                
                state.localExercisesVO.removeAll { $0.id == exerciseId }
            }
        } catch {
            Logger.main.error("Failed to delete exercise")
        }
    }
    
    func handleLocalExercises(localExercises: [LocalExerciseItem]) {
        state.localExercises = localExercises
        state.localExercisesVO = localExercises.map {
            .init(
                id: $0.id,
                exercise: .init(rawValue: $0.title) ?? .none,
                description: $0.exerciseDescription,
                durationMinutes: $0.durationMinutes,
                storageType: .local,
                locationName: $0.locationName,
                createdAt: $0.createdAt
            )
        }
    }
}


// MARK: - Private methods

private extension ExerciseListViewModel {
    
    func updateUserDetail() {
        do {
            let favoriteExercise = Dictionary(grouping: state.exercisesVO, by: \.exercise)
                .max { $0.value.count < $1.value.count }?
                .key ?? .none
            
            try userDetailClient.updateUserDetail(
                favoriteExercise.rawValue,
                state.allExercises.count,
                state.allExercises.map(\.durationMinutes).reduce(0, +)
            )
        } catch {
            Logger.main.error("updateUserDetail -> Failed to update user detail")
        }
    }
}

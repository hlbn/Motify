// swiftlint:disable line_length

import DesignKit
import FirebaseKit
import Foundation
import NavigationKit
import OSLog
import SwiftUI
import UIKit
import Dependencies
import UtilityKit


struct ExerciseViewState {
    
    // MARK: - Types definition
    
    enum DisplayMode {
        case add
        case edit
    }
    
    
    // MARK: - Properties
    
    var exerciseVO: ExerciseVO
    var displayMode: DisplayMode
    var isCreating = false
    
    var alert: AlertVO?
    var isLoading = false
    
    var didEdit = false
    
    
    // MARK: - Computed properties
    
    var isEditing: Bool {
        displayMode == .edit
    }
}

@MainActor
final class ExerciseViewModel: ObservableObject {
    
    struct Input {
        let exerciseVO: ExerciseVO?
    }
    
    
    // MARK: - State

    @Published var state: ExerciseViewState


    // MARK: - Services

    @Dependency(ExerciseClient.self) private var exerciseClient
    @Dependency(AuthClient.self) private var authClient


    // MARK: - Init

    init(input: Input) {
        if let exerciseVO = input.exerciseVO {
            self.state = .init(exerciseVO: exerciseVO, displayMode: .edit)
        } else {
            self.state = .init(exerciseVO: .empty, displayMode: .add, isCreating: true, didEdit: true)
        }
    }
    
    
    // MARK: - Actions
    
    func onSaveTap(dismiss: DismissAction) {
        performSaveIfPossible(dismiss: dismiss)
    }
    
    func onBackTap(dismiss: DismissAction) {
        if state.isEditing && state.didEdit {
            state.alert = .init(
                title: "exercise.leave.alert.title".localized,
                message: "exercise.leave.alert.message".localized,
                buttons: [
                    .destructive("exercise.leave.alert.confirm".localized) {
                        dismiss()
                    },
                    .cancel()
                ]
            )
        } else {
            dismiss()
        }
    }
}


// MARK: - Private methods

private extension ExerciseViewModel {
    
    func performSaveIfPossible(dismiss: DismissAction) {
        let exercise = state.exerciseVO
        let errors: [String] = [
            exercise.durationMinutes > 0 ? nil : "exercise.error.zerolength",
            exercise.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "exercise.error.titlerequired" : nil,
            exercise.description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "exercise.error.descriptionrequired" : nil
        ]
        .compactMap { $0 }
        
        if errors.isEmpty {
            saveExercise(dismiss: dismiss)
        } else {
            var message = "exercise.save.error".localized.translation + "\n\n"
            message.append(errors.map(\.localized.translation).joined(separator: "\n"))
            
            state.alert = .init(
                title: "exercise.save.alert.title".localized,
                message: .init(key: "exercise.save.alert.message", translation: message)
            )
        }
    }
    
    func saveExercise(dismiss: DismissAction) {
        UIApplication.hideKeyboard()
        state.isLoading = true
        
        do {
            try exerciseClient.saveExercise(state.exerciseVO, state.exerciseVO.id)
        } catch {
            state.alert = .init(
                title: "exercise.save.server.error".localized,
                message: "exercise.save.server.error.message".localized
            )
        }
        
        state.isLoading = false
    }
}


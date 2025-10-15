// swiftlint:disable line_length

import DesignKit
import FirebaseKit
import Foundation
import NavigationKit
import OSLog
import SwiftUI
import UIKit
import Dependencies
import MapKit
import SwiftData
import UtilityKit


struct ExerciseViewState {
    
    // MARK: - Types definition
    
    enum DisplayMode {
        case add
        case edit
    }
    
    
    // MARK: - Properties
    
    fileprivate var localExercises = [LocalExerciseItem]()
    
    var exerciseVO: ExerciseVO
    var displayMode: DisplayMode
    var isShowingMapPicker = false
    var isShowingTypePicker = false
    var isSavedOnCloud = true
    
    var alert: AlertVO?
    var isLoading = false
    
    
    // MARK: - Computed properties
    
    var navigationTitle: String {
        switch displayMode {
        case .add:
            return "exercise.add.nav.title".localized.translation
        case .edit:
            return "exercise.edit.nav.title".localized.translation
        }
    }
    
    var isEditing: Bool {
        displayMode == .edit
    }
    
    var minutesPickerData: [Int] {
        var data = [Int]()
        
        for index in 0...48 {
            data.append(index * 5)
        }
        
        return data
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
            self.state = .init(exerciseVO: exerciseVO, displayMode: .edit, isSavedOnCloud: exerciseVO.storageType == .remote)
        } else {
            self.state = .init(exerciseVO: .empty, displayMode: .add)
        }
    }
    
    
    // MARK: - Actions
    
    func onAppear(localExercises: [LocalExerciseItem]) {
        state.localExercises = localExercises
    }
    
    func onSaveTap(context: ModelContext, dismiss: DismissAction) async {
        await performSaveIfPossible(context: context, dismiss: dismiss)
    }
    
    func onTypePickerTap() {
        state.isShowingTypePicker = true
    }
    
    func onTypePicked(type: ExerciseVO.Exercise) {
        state.exerciseVO.exercise = type
        state.isShowingTypePicker = false
    }
    
    func onMapPickerTap() {
        state.isShowingMapPicker = true
    }
    
    func onMapItemPicked(mapItem: MKMapItem?) {
        guard let mapItem else {
            return
        }
        
        state.exerciseVO.locationName = mapItem.name
        state.isShowingMapPicker = false
    }
    
    func onBackTap(dismiss: DismissAction) {
        if state.isEditing {
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
    
    func performSaveIfPossible(context: ModelContext, dismiss: DismissAction) async {
        let exercise = state.exerciseVO
        let errors: [String] = [
            exercise.durationMinutes > 0 ? nil : "exercise.error.zerolength",
            exercise.exercise == .none ? "exercise.error.titlerequired" : nil,
            exercise.description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "exercise.error.descriptionrequired" : nil
        ]
        .compactMap { $0 }
        
        if errors.isEmpty {
            await saveExercise(context: context, dismiss: dismiss)
        } else {
            var message = "exercise.save.error".localized.translation + "\n\n"
            message.append(errors.map(\.localized.translation).joined(separator: "\n"))
            
            state.alert = .init(
                title: "exercise.save.alert.title".localized,
                message: .init(key: "exercise.save.alert.message", translation: message)
            )
        }
    }
    
    func saveExercise(context: ModelContext, dismiss: DismissAction) async {
        UIApplication.hideKeyboard()
        state.isLoading = true
        
        do {
            switch state.displayMode {
            case .add:
                try handleExerciseAdd(context: context)
            case .edit:
                try handleExerciseEdit(context: context)
            }
             
            dismiss()
        } catch {
            state.alert = .init(
                title: "exercise.save.server.error".localized,
                message: "exercise.save.server.error.message".localized
            )
        }
        
        state.isLoading = false
    }
    
    func handleExerciseAdd(context: ModelContext) throws {
        if state.isSavedOnCloud {
            try exerciseClient.saveExercise(state.exerciseVO, nil)
        } else {
            let item = LocalExerciseItem(from: state.exerciseVO)
            context.insert(item)
            
            try? context.save()
        }
    }
    
    func handleExerciseEdit(context: ModelContext) throws {
        guard let id = state.exerciseVO.id else {
            return
        }
        
        if state.isSavedOnCloud, state.exerciseVO.storageType == .remote {
            try exerciseClient.saveExercise(state.exerciseVO, id)
        } else if state.isSavedOnCloud, state.exerciseVO.storageType == .local {
            guard let item = state.localExercises.first(where: { $0.id == id }) else {
                Logger.main.error("Failed to update exercise, no exercise with id: \(id) found")
                return
            }
            
            context.delete(item)
            try context.save()
            
            try exerciseClient.saveExercise(state.exerciseVO, nil)
        } else if !state.isSavedOnCloud, state.exerciseVO.storageType == .remote {
            try exerciseClient.deleteExercise(id)
            
            let item = LocalExerciseItem(from: state.exerciseVO)
            context.insert(item)
            
            try context.save()
        }
    }
}


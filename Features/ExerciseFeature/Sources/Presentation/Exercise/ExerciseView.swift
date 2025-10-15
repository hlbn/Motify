//

import DesignKit
import NavigationKit
import SwiftUI
import MapKit
import MapItemPicker
import SwiftData
import UtilityKit


struct ExerciseView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: ExerciseViewModel
    @EnvironmentObject private var router: ExerciseRouter
    @Environment(\.isLocalStorageDisabled) private var isLocalStorageDisabled
    @Environment(\.modelContext) private var modelContext
    @Query var localExercises: [LocalExerciseItem]
    
    
    // MARK: - Environment
    
    @Environment(\.dismiss) var dismiss
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    ExerciseTypeTile(exercise: viewModel.state.exerciseVO.exercise) {
                        viewModel.onTypePickerTap()
                    }
                    .opacity(viewModel.state.isEditing ? 0.5 : 1)
                    .disabled(viewModel.state.isEditing)
                    
                    ThemedDivider()
                    
                    HStack {
                        Text("exercise.description".localized.translation)
                            .font(.caption, color: .contentMain)
                        
                        Spacer(minLength: 50)
                        
                        TextField(
                            "exercise.description.hint".localized.translation,
                            text: $viewModel.state.exerciseVO.description,
                            axis: .vertical
                        )
                            .font(.caption2, color: .contentMain)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    VStack(spacing: 16) {
                        ThemedDivider()
                        
                        HStack {
                            Text("exercise.duration".localized.translation)
                                .font(.caption, color: .contentMain)
                            
                            Spacer()
                            
                            Picker("exercise.duration".localized.translation, selection: $viewModel.state.exerciseVO.durationMinutes) {
                                ForEach(viewModel.state.minutesPickerData, id: \.self) { minutes in
                                    Text("\(minutes) \("minutes".localized.translation)")
                                        .tag(minutes)
                                }
                            }
                        }
                        .pickerStyle(.menu)
                        
                        ThemedDivider()
                    }
                    
                    Button(action: viewModel.onMapPickerTap) {
                        HStack {
                            Text("exercise.location".localized.translation)
                                .font(.caption, color: .contentMain)
                            
                            Spacer()
                            
                            Text(viewModel.state.exerciseVO.locationName ?? "exercise.location.empty")
                                .font(.caption2, color: viewModel.state.exerciseVO.locationName == nil ? .hintGray : .contentMain)
                        }
                    }
                    
                    ThemedDivider()
                    
                    Toggle(isOn: $viewModel.state.isSavedOnCloud) {
                        Text("exercise.save.on.cloud".localized.translation)
                    }
                    .toggleStyle(.switch)
                    .font(.caption, color: .contentMain)
                    .disabled(isLocalStorageDisabled)

                }
                .padding(top: 12, leading: 24, bottom: 12, trailing: 24)
            }
            .disabled(viewModel.state.isShowingMapPicker)
            .mapItemPicker(isPresented: $viewModel.state.isShowingMapPicker) { item in
                viewModel.onMapItemPicked(mapItem: item)
            }
            .scrollableSheetable(isPresented: $viewModel.state.isShowingTypePicker) {
                ExerciseTypePickerView(onTypePicked: viewModel.onTypePicked)
            }
            
            PrimaryButton("exercise.save".localized) {
                Task { await viewModel.onSaveTap(context: modelContext, dismiss: dismiss) }
            }
        }
        .background(Color.backgroundMain)
        .navigationTitle(viewModel.state.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.backgroundMain, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .alert($viewModel.state.alert)
        .loading(viewModel.state.isLoading, isTransparent: true)
        .onAppear {
            viewModel.onAppear(localExercises: localExercises)
        }
    }
    
    
    // MARK: - Init
    
    init(viewModel: ExerciseViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
}


// MARK: - Preview

#Preview("ExerciseView") {
    ExerciseView(
        viewModel: .init(
            input: .init(exerciseVO: nil)
        )
    )
    .inNavigationView()
    .environmentObject(ExerciseRouter())
}


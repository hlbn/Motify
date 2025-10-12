//

import DesignKit
import NavigationKit
import SwiftUI
import MapKit
import MapItemPicker
import UtilityKit


struct ExerciseView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: ExerciseViewModel
    @EnvironmentObject private var router: ExerciseRouter
    
    
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
                    
                    ThemedDivider()
                    
                    Picker("exercise.duration".localized.translation, selection: $viewModel.state.exerciseVO.durationMinutes) {
                        ForEach(ExerciseVO.DurationMinutes.allCases, id: \.self) { minutes in
                            Text("\(minutes.rawValue) \("minutes".localized.translation)")
                                .tag(minutes)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .font(.caption, color: .contentMain)
                    
                    ThemedDivider()
                    
                    Button(action: viewModel.onMapPickerTap) {
                        HStack {
                            Text("exercise.location")
                                .font(.caption, color: .contentMain)
                            
                            Spacer()
                            
                            Text(viewModel.state.exerciseVO.locationName ?? "exercise.location.empty")
                                .font(.caption, color: .contentMain)
                        }
                    }
                    
                    ThemedDivider()
                    
                    Toggle(isOn: $viewModel.state.isSavedOnCloud) {
                        Text("exercise.save.on.cloud".localized.translation)
                    }
                    .toggleStyle(.switch)
                    .font(.caption, color: .contentMain)

                }
                .padding(.horizontal, 24)
            }
            .disabled(viewModel.state.isShowingMapPicker)
            .mapItemPicker(isPresented: $viewModel.state.isShowingMapPicker) { item in
                viewModel.onMapItemPicked(mapItem: item)
            }
            .scrollableSheetable(isPresented: $viewModel.state.isShowingTypePicker) {
                ExerciseTypePickerView(onTypePicked: viewModel.onTypePicked)
            }
            
            PrimaryButton("exercise.save".localized) {
                viewModel.onSaveTap(dismiss: dismiss)
            }
        }
        .background(Color.backgroundMain)
        .navigationTitle("exercise.nav.title".localized.translation)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.backgroundMain, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .alert($viewModel.state.alert)
        .loading(viewModel.state.isLoading)
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


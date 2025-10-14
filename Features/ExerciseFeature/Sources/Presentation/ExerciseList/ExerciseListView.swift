//

import DesignKit
import Foundation
import NavigationKit
import SwiftUI
import SwiftData
import UtilityKit


struct ExerciseListView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: ExerciseListViewModel
    @EnvironmentObject private var router: ExerciseRouter
    
    @Environment(\.modelContext) private var modelContext
    @Query var localExercises: [LocalExerciseItem]

    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.state.filteredExercises) { exercise in
                    ExerciseTile(viewObject: exercise) {
                        viewModel.onWorkoutTap(exercise: exercise, router: router)
                    } dismissAction: {
                        viewModel.onExerciseDelete(context: modelContext, exercise: exercise)
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
        }
        .background(Color.backgroundMain)
        .navigationTitle("exercise.list.nav.title".localized.translation)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.backgroundMain, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.onCreateTap(router: router)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.mainBlue)
                        .bold()
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    Picker(selection: $viewModel.state.filter, label: EmptyView()) {
                        ForEach(ExerciseListViewState.ExerciseFilter.allCases, id: \.self) { filter in
                            Text(filter.title)
                                .tag(filter.rawValue)
                        }
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .foregroundStyle(Color.mainBlue)
                        .bold()
                }
            }
        }
        .onChange(of: localExercises) { _, newValue in
            viewModel.handleLocalExercises(localExercises: newValue)
        }
        .task {
            await viewModel.task(localExercises: localExercises)
        }
        .loading(viewModel.state.isLoading)
    }
    
    
    // MARK: - Init
    
    init(viewModel: ExerciseListViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
}


// MARK: - Previews

#Preview("ExerciseListView") {
    ExerciseListView(
        viewModel: .init()
    )
    .inNavigationView()
    .environmentObject(ExerciseRouter())
}

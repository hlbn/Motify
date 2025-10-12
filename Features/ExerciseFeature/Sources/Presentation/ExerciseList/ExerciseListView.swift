//

import DesignKit
import Foundation
import NavigationKit
import SwiftUI
import UtilityKit


struct ExerciseListView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: ExerciseListViewModel
    @EnvironmentObject private var router: ExerciseRouter

    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.state.exercisesVO) { exercise in
                    ExerciseTile(viewObject: exercise)
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
        }
        .background(Color.backgroundMain)
        .navigationTitle("exercise.title".localized.translation)
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
        }
        .task {
            await viewModel.task()
        }
        .loading(viewModel.state.isLoading, isTransparent: true)
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

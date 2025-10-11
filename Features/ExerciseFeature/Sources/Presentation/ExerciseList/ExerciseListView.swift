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
           
        }
        .frame(maxWidth: .infinity)
        .background(Color.bgMain)
        .navigationTitle("exercise.title".localized.translation)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.bgMain, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.onCreateTap(router: router)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.mainGreen)
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

//

import DesignKit
import NavigationKit
import SwiftUI
import UtilityKit


struct ProfileView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: ProfileViewModel
    @EnvironmentObject private var router: AuthRouter
    
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let favoriteExercise = viewModel.state.favoriteExercise {
                    Text("profile.favorite.exercise".localized.translation)
                        .font(.subheadline, color: .contentMain)
                        .padding(top: 24, leading: 0, bottom: 12, trailing: 0)
                    
                    favoriteExercise.icon
                        .resizable()
                        .frame(size: 100)
                        .bold()
                        .foregroundStyle(Color.mainBlue)
                    
                    Text(favoriteExercise.localized.translation)
                        .font(.title3, color: .contentMain)
                        .bold()
                        .padding(top: 0, leading: 24, bottom: 12, trailing: 24)
                }
                
                ThemedDivider()
                
                VStack(spacing: 12) {
                    Text("profile.total.hours".localized.translation)
                        .font(.subheadline, color: .contentMain)
                    
                    Text(viewModel.state.totalHours, format: .number)
                        .font(.title3, color: .contentMain)
                        .bold()
                }
                .padding(top: 12, leading: 24, bottom: 12, trailing: 24)
                
                ThemedDivider()
                
                VStack(spacing: 12) {
                    Text("profile.total.trainings".localized.translation)
                        .font(.subheadline, color: .contentMain)
                    
                    Text(viewModel.state.totalTrainings, format: .number)
                        .font(.title3, color: .contentMain)
                        .bold()
                }
                .padding(top: 12, leading: 24, bottom: 12, trailing: 24)
                
                ThemedDivider()
                
                VStack(spacing: 12) {
                    Text("profile.email".localized.translation)
                        .font(.subheadline, color: .contentMain)
                    
                    Text(viewModel.state.email)
                        .font(.title3, color: .contentMain)
                        .bold()
                }
                .padding(top: 12, leading: 24, bottom: 12, trailing: 24)
                
                ThemedDivider()
                
                SecondaryButton("profile.logout".localized) {
                    viewModel.onLogoutTap(router: router)
                }
                .padding(top: 24, leading: 0, bottom: 36, trailing: 0)
            }
        }
        .background(Color.backgroundMain)
        .navigationBarHidden(false)
        .alert($viewModel.state.alert)
        .task {
            await viewModel.task()
        }
    }
    
    
    // MARK: - Init
    
    init(viewModel: ProfileViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
}


// MARK: - Preview

#Preview("ProfileView") {
    ProfileView(
        viewModel: .init()
    )
    .environmentObject(AuthRouter())
}


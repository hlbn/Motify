//

import Dependencies
import DesignKit
import DataKit
import Foundation
import NavigationKit
import OSLog
import UtilityKit


struct ProfileViewState {
    
    // MARK: - Properties
    
    var email: String = .empty
    var alert: AlertVO?
    
    var favoriteExercise: ExerciseVO.Exercise?
    var totalTrainings = 0
    var daysSinceLastTraining = 0
    var totalHours = ""
}

@MainActor
final class ProfileViewModel: ObservableObject {
    
    // MARK: - State

    @Published var state = ProfileViewState()


    // MARK: - Services

    @Dependency(AuthClient.self) private var authClient
    @Dependency(LoginClient.self) private var loginClient
    @Dependency(UserDetailClient.self) private var userDetailClient


    // MARK: - Init

    init() {
        setupInitial()
    }
    
    
    // MARK: - Actions
    
    func task() async {
        do {
            let userDetail = try await userDetailClient.getUserDetail()
            
            state.favoriteExercise = .init(rawValue: userDetail.favoriteExercise ?? "none")
            state.totalTrainings = userDetail.totalTrainings ?? 0
            state.totalHours = minutesToHours(minutes: userDetail.totalMinutesOfTraining ?? 0)
        } catch {
            Logger.main.error("getUserDetail -> Failed to get user detail")
        }
    }
    
    func onLogoutTap(router: AuthRouter) {
        do {
            try authClient.logout()
            loginClient.savedCredentials = nil
            router.setAuthState(isLoggedIn: false)
        } catch {
            state.alert = .init(title: "logout.error".localized)
        }
    }
}


// MARK: - Private methods

private extension ProfileViewModel {
    
    func setupInitial() {
        state.email = authClient.getCurrentUserEmail() ?? "unknown".localized.translation
    }
    
    func minutesToHours(minutes: Int) -> String {
        let hours = minutes / 60
        let minutes = minutes % 60

        return "\(hours)h \(minutes)m"
    }
}

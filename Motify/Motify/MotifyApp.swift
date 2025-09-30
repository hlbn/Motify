//

import SwiftUI


@main
struct MotifyApp: App {
    
    // MARK: - Properties
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - App
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}

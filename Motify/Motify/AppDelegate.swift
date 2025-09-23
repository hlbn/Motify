//


import Foundation
import UIKit


class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
      
      setupFirebase()
      
      return true
  }
}


// MARK: - Private methods

private extension AppDelegate {
    
    func setupFirebase() {
        
    }
}

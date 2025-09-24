//

import Foundation


public extension Bundle {
    
    static func getAppVersion() -> String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "unknown"
    }
    
    static var utilityModule: Bundle {
        .module
    }
}

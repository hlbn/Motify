//

import Foundation


public struct Localization: Identifiable, Hashable {
    
    // MARK: - Properties
    
    public let key: String
    public let translation: String
    
    public var id: String {
        "\(key)-\(translation.hash)"
    }
    
    
    // MARK: - Init
    
    public init(key: String, translation: String) {
        self.key = key
        self.translation = translation
    }
    
    
    // MARK: - Predefined localizations
    
    public static var empty: Localization {
        Localization(key: "empty_string", translation: "")
    }
}

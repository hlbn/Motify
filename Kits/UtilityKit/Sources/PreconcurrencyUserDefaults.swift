//

import Foundation


public final class PreconcurrencyUserDefaults: @unchecked Sendable {
    
    // MARK: - Standard
    
    public static let standard = PreconcurrencyUserDefaults(userDefaults: .standard)
    
    
    // MARK: - Properties
    
    private let userDefaults: UserDefaults
    
    
    // MARK: - Init
    
    public init(suiteName: String?) {
        self.userDefaults = UserDefaults(suiteName: suiteName) ?? .standard
    }
    
    private init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}


// MARK: - Interface

public extension PreconcurrencyUserDefaults {
    
    func int(forKey key: String) -> Int {
        self.userDefaults.integer(forKey: key)
    }

    func string(forKey key: String) -> String? {
        self.userDefaults.string(forKey: key)
    }

    func bool(forKey key: String) -> Bool {
        self.userDefaults.bool(forKey: key)
    }

    func set(_ value: Bool, forKey key: String) {
        self.userDefaults.set(value, forKey: key)
    }

    func set(_ value: Int, forKey key: String) {
        self.userDefaults.set(value, forKey: key)
    }

    func set(_ value: String, forKey key: String) {
        self.userDefaults.set(value, forKey: key)
    }
}

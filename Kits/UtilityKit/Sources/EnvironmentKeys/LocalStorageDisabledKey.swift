//

import SwiftUI


// MARK: - EnvironmentKey

struct LocalStorageDisabledKey: EnvironmentKey {
  static let defaultValue: Bool = false
}


// MARK: - EnvironmentValues

extension EnvironmentValues {
    
  public var isLocalStorageDisabled: Bool {
    get { self[LocalStorageDisabledKey.self] }
    set { self[LocalStorageDisabledKey.self] = newValue }
  }
}

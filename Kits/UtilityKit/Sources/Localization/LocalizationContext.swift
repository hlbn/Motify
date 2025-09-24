//

import Foundation
import SwiftUI


public final class LocalizationContext: Sendable {
    
    public static let shared = LocalizationContext()

    public let languageBundle = Bundle.module
}

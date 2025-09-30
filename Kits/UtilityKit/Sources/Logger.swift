//

import Foundation
import OSLog


public extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.hlbn.Motify"

    static let main = Logger(subsystem: subsystem, category: "main")
}

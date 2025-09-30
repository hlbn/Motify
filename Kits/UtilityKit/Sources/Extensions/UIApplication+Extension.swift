//

import Foundation
import UIKit


public extension UIApplication {
    
    static func hideKeyboard() {
        shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

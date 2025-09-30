//

import Foundation


public enum Validator {
    
    public static func isEmailValid(_ email: String?) -> Bool {
        let regex = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{1,25})+"
        return Self.evaluateValueWithRegex(value: email, regex: regex)
    }
}


// MARK: - Private methods

private extension Validator {

    static func evaluateValueWithRegex(value: String?, regex: String) -> Bool {
        let predicator = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicator.evaluate(with: value)
    }
}

//

import Foundation


public extension String {
    
    var localized: Localization {
        let value = Bundle.module.localizedString(forKey: self, value: nil, table: nil)
        return Localization(key: self, translation: value)
    }
    
    func localized(arguments: CVarArg...) -> Localization {
        let value = withVaList(arguments) { localizer()( $0 ) }
        return Localization(key: self, translation: value)
    }
    
    var preview: Localization {
        Localization(key: self, translation: self)
    }
    
    static var empty: String { "" }
    
    func prefixStr(_ maxLength: Int) -> String {
        String(self.prefix(maxLength))
    }
    
    var removingNumbers: String {
        replacingOccurrences(of: "\\d", with: "", options: .regularExpression).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var withoutWhitespaces: String {
        replacingOccurrences(of: " ", with: "")
    }
}


// MARK: - Helpers

private extension String {
    
    func localizer() -> (_ params: CVaListPointer) -> String {
        let closure = { (params: CVaListPointer) in
            NSString(format: self.localized.translation, arguments: params) as String
        }
        return closure
    }
}

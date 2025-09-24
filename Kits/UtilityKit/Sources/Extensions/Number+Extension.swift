//

import Foundation


public extension Int64 {

    func toInt() -> Int {
        Int(self)
    }

    func toDouble() -> Double {
        Double(self)
    }

    func toString() -> String {
        String(self)
    }
}

public extension Int {

    func toInt64() -> Int64 {
        Int64(self)
    }

    func toString() -> String {
        String(self)
    }
}

public extension Double {
    
    func toString() -> String {
        String(self)
    }
}

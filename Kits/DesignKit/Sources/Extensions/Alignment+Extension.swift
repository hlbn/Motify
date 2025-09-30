//

import SwiftUI


public extension HorizontalAlignment {
    
    enum TextFieldHorizontal: AlignmentID {
        public static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
            dimensions[HorizontalAlignment.leading]
        }
    }
    
    static let textFieldHorizontal = HorizontalAlignment(TextFieldHorizontal.self)
}


public extension VerticalAlignment {
    
    enum TextFieldVertical: AlignmentID {
        public static func defaultValue(in dimensons: ViewDimensions) -> CGFloat {
            dimensons[VerticalAlignment.center]
        }
    }
    
    static let textFieldVertical = VerticalAlignment(TextFieldVertical.self)
}


public extension Alignment {
    static let textFieldAlignment = Alignment(horizontal: .textFieldHorizontal, vertical: .textFieldVertical)
}

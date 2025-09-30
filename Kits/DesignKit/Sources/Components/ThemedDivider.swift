//

import SwiftUI


public struct ThemedDivider: View {
    
    // MARK: - Properties
    
    private let color: Color

    
    // MARK: - Body

    public var body: some View {
        Divider()
            .frame(height: 0.5)
            .overlay(color)
    }


    // MARK: - Init

    public init(color: Color = .underline) {
        self.color = color
    }
}


// MARK: - Extension

#Preview("ThemedDivider") {
    ThemedDivider()
        .asComponentPreview()
}

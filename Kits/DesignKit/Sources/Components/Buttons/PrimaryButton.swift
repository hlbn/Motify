//

import SwiftUI
import UtilityKit


public struct PrimaryButton: View {
    
    // MARK: - Properties
    
    private let text: Localization
    private let action: () -> Void
    
    
    // MARK: - Body
    
    public var body: some View {
        Button(action: action) {
            Text(text.translation)
                .font(.headline, color: .bgMain)
                .bold()
                .padding(vertical: 12, horizontal: 34)
                .background(
                    Capsule()
                        .fill(Color.secondaryBlue)
                )
        }
    }
    
    
    // MARK: - Init
    
    public init(_ text: Localization, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
}


// MARK: - Preview

#Preview {
    PrimaryButton("Title text".localized, action: { })
        .padding()
        .asComponentPreview()
}

//

import SwiftUI
import UtilityKit


public struct TitleText: View {
    
    // MARK: - Properties
    
    private let text: Localization
    private let font: Font
    private let color: Color
    
    
    // MARK: - Body
    
    public var body: some View {
        Text(text.translation)
            .font(font, color: color)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(top: 24, leading: 0, bottom: 12, trailing: 0)
    }
    
    
    // MARK: - Init
    
    public init(_ text: Localization, font: Font = .title3, color: Color = .contentMain) {
        self.text = text
        self.font = font
        self.color = color
    }
}


// MARK: - Preview

#Preview {
    TitleText("Title text".localized, font: .title3, color: .contentMain)
        .padding()
        .asComponentPreview()
}

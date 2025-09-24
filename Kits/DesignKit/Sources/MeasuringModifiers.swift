//

import Foundation
import SwiftUI


private struct SizeValueKey: PreferenceKey {
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { }
    
    static let defaultValue: CGFloat = 0
}

public extension View {
    
    func heightMeasuring(completion: @escaping (CGFloat) -> Void) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SizeValueKey.self, value: proxy.size.height)
            }
        }
        .onPreferenceChange(SizeValueKey.self) {
            completion($0)
        }
    }
    
    func heightMeasuring(into binding: Binding<CGFloat>) -> some View {
        heightMeasuring {
            binding.wrappedValue = $0
        }
    }
}

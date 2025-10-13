//

import SwiftUI


struct SizeChangeNotifyingModifier: ViewModifier {

    // MARK: - Properties

    var onSizeChange: (CGSize) -> Void


    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onChange(of: proxy.size) { value in
                            Task { onSizeChange(value) }
                        }
                        .onAppear { onSizeChange(proxy.size) }
                }
            )
    }
}


// MARK: - View extension

public extension View {
    @ViewBuilder
    func onSizeChange(action: @escaping (CGSize) -> Void) -> some View {
        modifier(SizeChangeNotifyingModifier(onSizeChange: action))
    }
}

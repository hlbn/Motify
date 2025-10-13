//

import SwiftUI


struct SizeMeasuringModifier: ViewModifier {

    // MARK: - Properties

    @Binding var width: CGFloat
    @Binding var height: CGFloat


    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .onSizeChange { size in
                width = size.width
                height = size.height
            }
    }
}


// MARK: - View extension

public extension View {
    
    @ViewBuilder
    func sizeMeasuring(into binding: Binding<CGSize>, enabled: Bool = true) -> some View {
        if enabled {
            modifier(
                SizeMeasuringModifier(
                    width: .init(
                        get: { binding.wrappedValue.width },
                        set: { binding.wrappedValue.width = $0 }
                    ),
                    height: .init(
                        get: { binding.wrappedValue.height },
                        set: { binding.wrappedValue.height = $0 }
                    )
                )
            )
        } else {
            self
        }
    }
    
    @ViewBuilder
    func widthMeasuring(into binding: Binding<CGFloat>, enabled: Bool = true) -> some View {
        if enabled {
            modifier(SizeMeasuringModifier(width: binding, height: .constant(0)))
        } else {
            self
        }
    }
    
    @ViewBuilder
    func heightMeasuring(into binding: Binding<CGFloat>, enabled: Bool = true) -> some View {
        if enabled {
            modifier(SizeMeasuringModifier(width: .constant(0), height: binding))
        } else {
            self
        }
    }
}

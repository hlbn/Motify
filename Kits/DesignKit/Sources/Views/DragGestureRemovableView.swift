//

import SwiftUI


public struct DragGestureRemovableView: ViewModifier {
    
    // MARK: - Properties
    
    private let closeAction: () -> Void
    private let buttonAlignment: Alignment
    // Default on draggesture is 10, anything below 15 takes "priority" before scrollview (this changed in ios 18) meaning that you CANT scroll the scrollview when you start scrolling on view that has that draggesture in it
    // To make scrollview srollable even when starting on the tile with draggesture, use values over 15 like 20 or 30
    // Simultaneous gesture would work also but then scrollview still moves up and down when doing the gesture - which we found weird
    // https://stackoverflow.com/a/78938981
    private let minimumDistance: CGFloat
    @State var contentWidth: CGFloat = 0
    @State var isSwiped = false
    @State var offset: CGFloat = 0
    @State var buttonSize: CGFloat = 0
    
    
    // MARK: - Computed properies
    
    private var buttonVisible: Bool {
        buttonSize > 0
    }
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        ZStack(alignment: buttonAlignment) {
            HStack {
                Spacer()
                
                if buttonVisible {
                    Button {
                        closeAction()
                    } label: {
                       Image(systemName: "xmark.bin.circle.fill")
                            .resizable()
                            .frame(size: buttonSize)
                            .foregroundStyle(Color.mainRed)
                            .symbolEffect(.scale)
                    }
                    .transition(.scale.combined(with: .opacity))
                    .padding(.horizontal, 24)
                } else {
                    EmptyView()
                }
            }
            .padding(.bottom, 16)
            .animation(.bouncy, value: buttonVisible)
            
            content
                .widthMeasuring(into: $contentWidth)
                .offset(x: offset)
                .gesture(DragGesture(minimumDistance: minimumDistance).onChanged(onChanged).onEnded(onEnded))
                .animation(.easeInOut, value: offset)
        }
        .animation(.easeOut, value: isSwiped)
    }
    
    
    // MARK: - Init
    
    public init(
        closeAction: @escaping () -> Void,
        buttonAlignment: Alignment = .center,
        minimumDistance: CGFloat = 25
    ) {
        self.closeAction = closeAction
        self.buttonAlignment = buttonAlignment
        self.minimumDistance = minimumDistance
    }
}


// MARK: - Drag gesture

private extension DragGestureRemovableView {
    
    func onChanged(_ value: DragGesture.Value) {
        // Checking if tile was moved
        if value.translation.width < 0 {
            buttonSize = 40
            
            if !isSwiped || isSwiped && value.translation.width < offset {
                offset = value.translation.width
            } else {
                offset = 0
            }
        }
    }
    
    func onEnded(_ value: DragGesture.Value) {
        // Checking if tile was moved or is back at it's original position
        if value.translation.width < 0 {
            if -value.translation.width > contentWidth / 2 {
                // If tile was dragged more then half a screen we'll call close action.
                buttonSize = 0
                closeAction()
            } else if -offset > 50 && !isSwiped {
                // Else if tile was dragged enough for close button to completly appear,
                // we change isSwiped to true to lock tile.
                isSwiped = true
                offset = -100
            } else {
                // Else we let tile to go back to it's original position
                buttonSize = 0
                isSwiped = false
                offset = 0
            }
            // Setting tile back to it's original position
        } else {
            buttonSize = 0
            isSwiped = false
            offset = 0
        }
    }
}


// MARK: - View extension

public extension View {
    @ViewBuilder
    func dragDismissable(
        _ closeAction: @escaping () -> Void,
        buttonAlignment: Alignment = .center,
        minimumDistance: CGFloat = 25
    ) -> some View {
        modifier(DragGestureRemovableView(closeAction: closeAction, buttonAlignment: buttonAlignment, minimumDistance: minimumDistance))
    }
}


//

import SwiftUI
import UtilityKit


private struct SheetableModifier<SheetContent: View>: ViewModifier {
    
    // MARK: - Properties

    @Binding var isPresented: Bool
    let title: Localization?
    let showHandle: Bool
    let wrappedInNavigation: Bool
    @ViewBuilder let sheetContent: () -> SheetContent
    @State var sheetHeight: CGFloat?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var isShownAsFormSheet: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
    
    @State private var selectedDetent = PresentationDetent.height(UIScreen.main.bounds.height * 0.85)

    
    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                Group {
                    if wrappedInNavigation {
                        NavigationStack {
                            sheetableContent
                        }
                    } else {
                        sheetableContent
                    }
                }
                .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                    // Do not trust values below zero
                    // This only happens in navigationSheetable on iPhone SE (or smaller - similar devices) + toolbar + keyboard
                    // Somehow apple has bug, that toolbar constraints are totally broken (even when called from SwiftUI)
                    // Similar to see: https://developer.apple.com/forums/thread/729828
                    // Constraints break cause preferences to report zero values (0.0)
                    // So when u show navigation sheetable with keyboard and with toolbar height goes like: 250 (real), 0.0 (after constraint break), the second preference call overwrites the correct height (but it does not make sense to have content of height 0)
                    // No other case reports 0 height, so we can safely ignore when newHeight is 0.0
                    // This fixes the bug, that view disappears and only keyboard is left
                    guard newHeight > 0 else {
                        return
                    }
                    
                    sheetHeight = newHeight
                    selectedDetent = .height(getSheetHeight())
                }
                .presentationDetents([.height(getSheetHeight())], selection: $selectedDetent)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                selectedDetent = .height(getSheetHeight())
            }
    }

    
    // MARK: - Helpers

    private var sheetableContent: some View {
        VStack {
            header
            sheetContent()
            if isShownAsFormSheet {
                Spacer()
            }
        }
        .overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
            }
        }
    }

    @ViewBuilder private var header: some View {
        if showHandle {
            VStack(spacing: 12) {
                Rectangle()
                    .fill(Color.underline)
                    .frame(width: 28, height: 4)
                    .cornerRadius(2)
                    .padding(.top, 8)
                
                ZStack(alignment: .trailing) {
                    if let title {
                        Text(title.translation)
                            .font(.title3, color: .contentMain)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 40)
                    }

                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(size: 14)
                            .foregroundStyle(Color.content75)
                    }
                    .padding(.trailing, 24)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        } else {
            ZStack(alignment: .trailing) {
                if let title {
                    Text(title.translation)
                        .font(.title3, color: .contentMain)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 40)
                }

                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(size: 14)
                        .foregroundStyle(Color.content75)
                }
                .padding(.trailing, 24)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 24)
        }
    }
    
    func getSheetHeight() -> CGFloat {
        if let sheetHeight {
            return sheetHeight
        } else {
            return UIScreen.main.bounds.height * 0.85
        }
    }
}


// MARK: - ScrollableSheetable

struct ScrollableSheetable<SheetContent: View>: ViewModifier {
    
    // MARK: - Properties
    
    @State private var sheetContentHeight: CGFloat = 0
    @Binding var isPresented: Bool
    let maxHeight: CGFloat?
    let title: Localization?
    let showHandle: Bool
    @ViewBuilder let sheetContent: () -> SheetContent
    
    
    // MARK: - Computed properties
    
    var defaultMaxHeight: CGFloat {
        UIScreen.main.bounds.height / 2
    }

    var scrollViewHeight: CGFloat? {
        // Scrollview height has to be set depending on iOS version because of
        // different implementation of sheetable for iOS 15
        if #available(iOS 16.0, *) {
            return min(sheetContentHeight, maxHeight ?? defaultMaxHeight)
        } else {
            return nil
        }
    }
    
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .sheetable(
                isPresented: $isPresented,
                title: title,
                showHandle: showHandle
            ) {
                ScrollView(showsIndicators: false) {
                    sheetContent()
                        .heightMeasuring(into: $sheetContentHeight)
                }
                .frame(height: scrollViewHeight)
            }
    }
}


private struct InnerHeightPreferenceKey: @MainActor PreferenceKey {
    @MainActor static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


// MARK: - Extension

public extension View {
    
    func sheetable(
        isPresented: Binding<Bool>,
        title: Localization? = nil,
        showHandle: Bool = false,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(
            SheetableModifier(
                isPresented: isPresented,
                title: title,
                showHandle: showHandle,
                wrappedInNavigation: false,
                sheetContent: content
            )
        )
    }
    
    func scrollableSheetable(
        isPresented: Binding<Bool>,
        maxHeight: CGFloat? = nil,
        title: Localization? = nil,
        showHandle: Bool = false,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(
            ScrollableSheetable(
                isPresented: isPresented,
                maxHeight: maxHeight,
                title: title,
                showHandle: showHandle,
                sheetContent: content
            )
        )
    }
}


// MARK: - Preview

#Preview("SheetableView") {
    withState(false) { isPresented in
        VStack {
            Text("Hello")
            Button("Show") {
                isPresented.wrappedValue.toggle()
            }
        }
        .sheetable(
            isPresented: isPresented,
            title: "Hello".localized,
            showHandle: true
        ) {
            VStack {
                Text("World from sheet")
                Rectangle()
                    .frame(width: 100, height: 200)
            }
        }
    }
}

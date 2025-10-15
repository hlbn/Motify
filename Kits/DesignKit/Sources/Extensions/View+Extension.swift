// swiftlint:disable identifier_name

import SwiftUI
import UtilityKit


// MARK: - View convenience helpers

public extension View {
    
    func padding(vertical: CGFloat, horizontal: CGFloat) -> some View {
        self
            .padding(.vertical, vertical)
            .padding(.horizontal, horizontal)
    }
    
    func padding(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> some View {
        self
            .padding(.top, top)
            .padding(.leading, leading)
            .padding(.bottom, bottom)
            .padding(.trailing, trailing)
    }
    
    func font(_ font: Font, color: Color) -> some View {
        self
            .font(font)
            .foregroundColor(color)
    }
    
    func frame(size: CGFloat, alignment: Alignment = .center) -> some View {
        self
            .frame(width: size, height: size, alignment: alignment)
    }
    
    func navigationTitle(_ title: Localization) -> some View {
        self
            .navigationTitle(title.translation)
    }
}


// MARK: - Alert

public extension View {
    
    func alert(_ binding: Binding<AlertVO?>) -> some View {
        modifier(AlertVisibilityManager(bindingAlert: binding))
    }
}


// MARK: - View logic helpers

public extension View {
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func `switch`<T, Content: View>(value: T, @ViewBuilder transform: (Self, T) -> Content) -> some View {
        transform(self, value)
    }

    @ViewBuilder
    func ifLet<Content: View, T: Hashable>(_ value: T?, @ViewBuilder transform: (Self, T) -> Content) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func ifLet<Content: View, T: Equatable>(_ value: T?, @ViewBuilder transform: (Self, T) -> Content) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
}


// MARK: - Shadow

public extension View {
    
    /// Aplies specified shadow to the view
    ///
    /// - Returns: A view with a shadow
    func tileShadow(
        color: Color = Color.darkShadow,
        radius: CGFloat = 10,
        x: CGFloat = 0,
        y: CGFloat = 4
    ) -> some View {
        self
            .shadow(color: color, radius: radius, x: x, y: y)
    }
}


// MARK: - Preview helpers

public extension View {
    
    func asComponentPreview() -> some View {
        VStack {
            self
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.backgroundMain)
            self
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.backgroundMain)
                .environment(\.colorScheme, .dark)
        }
    }
    
    func inNavigationView() -> some View {
        NavigationView {
            self
        }
    }
}

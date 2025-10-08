//

import Foundation
import SwiftUI


public struct LoadingViewModifier: ViewModifier {

    // MARK: - Properties
    
    private let isLoading: Bool
    private let isTransparent: Bool
    @State private var isRotating = false
    
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        content
            .disabled(isLoading)
            .overlay {
                if isLoading {
                    if !isTransparent {
                        Color.white.ignoresSafeArea()
                    }
                    
                    
                    ProgressView()
                }
            }
    }


    // MARK: - Init

    public init(isLoading: Bool, isTransparent: Bool = false) {
        self.isLoading = isLoading
        self.isTransparent = isTransparent
    }
}


// MARK: - Convenience modifier for all views

public extension View {
    
    func loading(_ isLoading: Bool, isTransparent: Bool = false) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading, isTransparent: isTransparent))
    }
}


// MARK: - Preview

#Preview("LoadingView") {
    withState(false) { isLoading in
        VStack {
            Text("SomeContent")
            Button("Load") {
                isLoading.wrappedValue = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isLoading.wrappedValue = false
                }
            }
        }
        .loading(isLoading.wrappedValue)
    }
}

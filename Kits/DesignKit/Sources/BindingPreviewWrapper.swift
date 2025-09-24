//

import Foundation
import SwiftUI


struct BindingPreviewWrapper<Value, Content: View>: View {
    
    // MARK: - Properties
    
    @State private var value: Value
    private var content: (Binding<Value>) -> Content

    
    // MARK: - Body
    
    var body: some View {
        content($value)
    }

    
    // MARK: - Init
    
    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}


// MARK: - Helper function

@MainActor
public func withState<Value, Content: View>(
    _ value: Value,
    content: @escaping (Binding<Value>) -> Content
) -> some View {
    BindingPreviewWrapper(value, content: content)
}


// MARK: - Preview

#Preview("BindingPreviewWrapper") {
    withState(false) { value in
        Toggle(isOn: value) {
            Text("Binding preview")
        }
    }
    .asComponentPreview()
}

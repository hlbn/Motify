//

import Foundation
import SwiftUI


struct AlertVisibilityManager: ViewModifier {
    
    // MARK: - Properties
    
    @State private var presentingAlert: AlertVO?
    @Binding var bindingAlert: AlertVO?
    
    
    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .alert(
                bindingAlert?.title.translation ?? "",
                isPresented: .init(
                    get: { bindingAlert != nil },
                    set: { newValue in
                        if presentingAlert != bindingAlert {
                            return
                        }
                        
                        if !newValue {
                            bindingAlert = nil
                        }
                    }
                ),
                presenting: bindingAlert,
                actions: { model in
                    ForEach(model.buttons) { button in
                        Button(role: button.role) {
                            button.action?()
                        } label: {
                            Text(button.title.translation)
                        }
                    }
                },
                message: { model in
                    if let message = model.message {
                        Text(message.translation)
                    }
                }
            )
            .onChange(of: bindingAlert) {
                presentingAlert = $0
            }
    }
}

//

import Foundation
import SwiftUI
import UtilityKit


public struct UnderlinedTextField: View {

    // MARK: - Properties
    
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    private let placeholder: Localization
    private let keyboardType: UIKeyboardType
    private let isEditable: Bool
    private var isTextFieldEnabled: Bool
    private let error: Localization?
    private let hint: Localization?
    private let detail: Detail?
    private let animateError: Bool
    private let isSecure: Bool

    
    // MARK: - Computed properties
    
    private var isNonEmptyOrFocused: Bool {
        !text.isEmpty || isFocused
    }

    private var color: Color {
        guard error == nil else {
            return .mainRed
        }
        
        return isFocused ? .mainGreen : .content75
    }

    private var underlineColor: Color {
        guard error == nil else {
            return .mainRed
        }
        
        return isFocused ? .mainGreen : .underline
    }
    

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                ZStack(alignment: .textFieldAlignment) {
                    Text(placeholder.translation)
                        .font(.caption, color: color)
                        .scaleEffect(
                            x: isNonEmptyOrFocused ? 0.75 : 1,
                            y: isNonEmptyOrFocused ? 0.75 : 1,
                            anchor: UnitPoint(x: 0, y: -2)
                        )
                        .frame(alignment: .leading)
                        .animation(.default, value: isFocused)
                        .alignmentGuide(VerticalAlignment.textFieldVertical) { dimensions in
                            dimensions[.bottom] / 2
                        }
                        .accessibilityHidden(true)

                    if let detailText = detail?.text {
                        textField
                            .accessibilityLabel(detailText)
                    } else {
                        textField
                    }
                }
                .disabled(!isTextFieldEnabled)

                HStack(spacing: .zero) {
                    if let detailText = detail?.text {
                        Text(detailText)
                            .font(.caption, color: .content75)
                            .accessibilityHidden(true)
                            .if(detail?.actionButton != nil) {
                                $0.padding(.trailing, 8)
                            }
                    }

                    if let actionButton = detail?.actionButton {
                        Button(action: actionButton.action) {
                            actionButton.image
                                .renderingMode(.template)
                                .foregroundColor(actionButton.color)
                        }
                        .if(detail?.secondaryActionButton == nil) {
                            $0.padding(.trailing, 10)
                        }
                        .if(detail?.secondaryActionButton != nil) {
                            $0.padding(.horizontal, 10)
                        }
                    }

                    if let secondaryActionButton = detail?.secondaryActionButton {
                        Button(action: secondaryActionButton.action) {
                            secondaryActionButton.image
                                .renderingMode(.template)
                                .foregroundColor(secondaryActionButton.color)
                        }
                        .padding(.leading, 10)
                    }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if !isEditable, let actionButton = detail?.actionButton {
                    actionButton.action()
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                ThemedDivider(color: underlineColor)
                    .animation(.default, value: isFocused)

                if let error, !error.translation.isEmpty {
                    Text(error.translation)
                        .font(.caption, color: color)
                        .transition(.move(edge: .top).combined(with: .opacity))
                } else if let hint = hint {
                    Text(hint.translation)
                        .font(.caption, color: color)
                }
            }
            .clipped()
        }
        .padding(.top, 15)
        .animation(animateError ? .easeIn : nil, value: error)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(placeholder.key)
        .accessibilityLabel(placeholder.translation)
    }

    private var textField: some View {
        Group {
            if isSecure {
                SecureField("", text: $text)
                    .frame(minHeight: 21)
                    .autocorrectionDisabled()
                    .textContentType(.oneTimeCode) // fixes weird passwword bar blinking ios 17 (but disables it)
            } else {
                TextField("", text: $text)
                    .autocorrectionDisabled()
                    .textContentType(.oneTimeCode) // fixes weird passwword bar blinking ios 17 (but disables it)
            }
        }
        .font(.caption, color: isTextFieldEnabled ? .contentMain : .content50)
        .alignmentGuide(VerticalAlignment.textFieldVertical) { dimensions in
            dimensions[.top]
        }
        .focused($isFocused)
        .autocapitalization(.none)
        .keyboardType(keyboardType)
        .accessibilityIdentifier("\(placeholder.key)_value")
        .disabled(!isEditable)
    }


    // MARK: - Init

    public init(
        _ placeholder: Localization,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        isEditable: Bool = true,
        isTextFieldEnabled: Bool = true,
        error: Localization? = nil,
        hint: Localization? = nil,
        detail: Detail? = nil,
        animateError: Bool = true,
        isSecure: Bool = false
    ) {
        self.placeholder = placeholder
        self._text = text
        self.keyboardType = keyboardType
        self.isEditable = isEditable
        self.isTextFieldEnabled = isTextFieldEnabled
        self.error = error
        self.hint = hint
        self.detail = detail
        self.animateError = animateError
        self.isSecure = isSecure
    }
    
    
    // MARK: - Structs

    public struct Detail {

        public struct ActionButton {
            public let image: Image
            public let color: Color
            public let action: () -> Void

            public init(
                image: Image,
                color: Color = .mainGreen,
                action: @escaping () -> Void
            ) {
                self.image = image
                self.color = color
                self.action = action
            }
        }

        
        // MARK: - Properties

        public let text: String?
        public let actionButton: ActionButton?
        public let secondaryActionButton: ActionButton?


        // MARK: - Init

        public init(
            text: String? = nil,
            actionButton: UnderlinedTextField.Detail.ActionButton? = nil,
            secondaryActionButton: UnderlinedTextField.Detail.ActionButton? = nil
        ) {
            self.text = text
            self.actionButton = actionButton
            self.secondaryActionButton = secondaryActionButton
        }
    }
}


// MARK: - Preview

private struct TextFieldPreviewWrapper: View {
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            UnderlinedTextField(
                "Placeholder".preview,
                text: .constant("Text with a placeholder")
            )

            UnderlinedTextField(
                "Placeholder".preview,
                text: .constant(.empty),
                hint: "Field with a placeholder and a hint".preview
            )

            UnderlinedTextField(
                "Detail text and two actions".preview,
                text: .constant(.empty),
                detail: .init(
                    text: "kg",
                    actionButton: .init(image: .init(systemName: "pencil")) {},
                    secondaryActionButton: .init(image: .init(systemName: "info")) {}
                )
            )

            UnderlinedTextField(
                "Placeholder".preview,
                text: .constant("wrong input"),
                error: "Field with an error".preview
            )
            .previewDisplayName("Error")
        }
        .padding(.horizontal)
        .asComponentPreview()
    }
}

#Preview("UnderlinedTextField") {
    TextFieldPreviewWrapper()
}

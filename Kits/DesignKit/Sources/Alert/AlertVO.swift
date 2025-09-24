//

import Foundation
import SwiftUI
import UtilityKit


public struct AlertVO: Identifiable, Equatable {

    // MARK: - Types definition
    
    public struct AlertButtonVO: Identifiable, Equatable {
        
        // MARK: - Properties
        
        public let id = UUID()
        let title: Localization
        let role: ButtonRole?
        let action: (() -> Void)?
        
        
        // MARK: - Init
        
        public init(
            role: ButtonRole?,
            title: Localization,
            action: (() -> Void)? = nil
        ) {
            self.role = role
            self.title = title
            self.action = action
        }
        
        
        // MARK: - Helpers
        
        public static func cancel(
            _ title: Localization = "common_button_cancel".localized,
            action: (() -> Void)? = nil
        ) -> Self {
            .init(role: .cancel, title: title, action: action)
        }
        
        public static func destructive(_ title: Localization, action: (() -> Void)? = nil) -> Self {
            .init(role: .destructive, title: title, action: action)
        }
        
        public static func `default`(
            _ title: Localization = "common_button_ok".localized,
            action: (() -> Void)? = nil
        ) -> Self {
            .init(role: .none, title: title, action: action)
        }
        
        
        // MARK: - Equatable
        
        public static func == (lhs: AlertVO.AlertButtonVO, rhs: AlertVO.AlertButtonVO) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    
    // MARK: - Properties
    
    public let id = UUID()
    let title: Localization
    let message: Localization?
    let buttons: [AlertButtonVO]

    
    // MARK: - Init
    
    public init(
        title: Localization,
        message: Localization? = nil,
        buttons: [AlertButtonVO] = [.default()]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}


// MARK: - AlertVO Extension

public extension AlertVO {
    
    static func commonError(action: (() -> Void)? = nil) -> AlertVO {
        .init(
            title: "common_dialog_error_title".localized,
            message: "common_dialog_error_message".localized,
            buttons: [
                .default(
                    action: action ?? { } // Empty closure otherwise user cannot dismiss the alert
                )
            ]
        )
    }
}

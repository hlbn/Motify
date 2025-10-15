//

import Foundation
import Dependencies
import DesignKit
import UtilityKit


public struct UserDetailClient: Sendable {
    public var getUserDetail: @Sendable () async throws -> UserDetailVO
    public var updateUserDetail: @Sendable (String, Int, Int) throws -> Void
    
    public init(
        getUserDetail: @Sendable @escaping () async throws -> UserDetailVO,
        updateUserDetail: @Sendable @escaping (String, Int, Int) throws -> Void
    ) {
        self.getUserDetail = getUserDetail
        self.updateUserDetail = updateUserDetail
    }
}


// MARK: - Preview

extension UserDetailClient: TestDependencyKey {
    
    public static var previewValue: UserDetailClient { testValue }
    public static var testValue: UserDetailClient {
        UserDetailClient(
            getUserDetail: { .preview },
            updateUserDetail: { _, _, _ in }
        )
    }
}

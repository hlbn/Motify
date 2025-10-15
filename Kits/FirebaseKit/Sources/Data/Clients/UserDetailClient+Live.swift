//

import Foundation
import Dependencies
import DataKit


// MARK: - Dependency registration

extension UserDetailClient: DependencyKey {
    
    public static var liveValue: UserDetailClient {
        let service = UserDetailService()
        return .init(
            getUserDetail: service.getUserDetail,
            updateUserDetail: service.updateUserDetail
        )
    }
}

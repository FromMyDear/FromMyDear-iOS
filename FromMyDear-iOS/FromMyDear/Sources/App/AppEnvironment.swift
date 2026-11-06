import Foundation
import Observation

/// 앱 전체에서 공유하는 설정과 서비스.
/// `USE_MOCK_SERVICES` 값에 따라 Mock 또는 실제 API 구현을 주입한다.
@MainActor
@Observable
final class AppEnvironment {
    let config: AppConfig
    let healthService: any HealthService

    init(config: AppConfig) {
        self.config = config
        if config.useMockServices {
            healthService = MockHealthService()
        } else {
            let client = APIClient(baseURL: config.apiBaseURL)
            healthService = LiveHealthService(client: client)
        }
    }
}

import Foundation
import Observation

/// 화면 상태와 로직을 View에서 분리하는 기본 패턴 예시.
@MainActor
@Observable
final class ServerStatusViewModel {
    enum State: Equatable {
        case idle, loading, up, down
    }

    private(set) var state: State = .idle

    func check(using service: any HealthService) async {
        state = .loading
        do {
            let isUp = try await service.isServerUp()
            state = isUp ? .up : .down
        } catch is CancellationError {
            state = .idle
        } catch {
            state = .down
        }
    }
}

import Foundation

/// 서버 연결 확인. Mock ↔ 실제 구현 교체 방식의 예시이며,
/// 이후 AuthService, CoupleService 등도 같은 형태(프로토콜 + Mock + Live)로 만든다.
protocol HealthService: Sendable {
    func isServerUp() async throws -> Bool
}

struct LiveHealthService: HealthService {
    let client: APIClient

    private struct HealthResponse: Decodable {
        let status: String
    }

    func isServerUp() async throws -> Bool {
        let response: HealthResponse = try await client.get("actuator/health")
        return response.status == "UP"
    }
}

struct MockHealthService: HealthService {
    var result: Bool = true

    func isServerUp() async throws -> Bool {
        try await Task.sleep(for: .milliseconds(300))
        return result
    }
}

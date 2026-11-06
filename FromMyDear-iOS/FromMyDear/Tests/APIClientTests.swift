import Foundation
import Testing
@testable import FromMyDear

private struct StubTransport: HTTPTransport {
    let status: Int
    let body: String

    func send(_ request: URLRequest) async throws -> (Data, URLResponse) {
        let response = HTTPURLResponse(url: request.url!, statusCode: status, httpVersion: nil, headerFields: nil)!
        return (Data(body.utf8), response)
    }
}

private struct Health: Decodable {
    let status: String
}

struct APIClientTests {
    private let baseURL = URL(string: "http://localhost:8080")!

    @Test func decodesSuccessfulResponse() async throws {
        let client = APIClient(baseURL: baseURL, transport: StubTransport(status: 200, body: #"{"status":"UP"}"#))

        let health: Health = try await client.get("actuator/health")

        #expect(health.status == "UP")
    }

    @Test func mapsStandardServerErrorCode() async {
        let body = #"{"code":"UNAUTHORIZED","message":"로그인이 필요합니다.","fieldErrors":[]}"#
        let client = APIClient(baseURL: baseURL, transport: StubTransport(status: 401, body: body))

        await #expect(throws: APIError.http(status: 401, code: "UNAUTHORIZED")) {
            let _: Health = try await client.get("api/v1/me")
        }
    }

    @MainActor
    @Test func serverStatusBecomesDownWhenServiceReportsFalse() async {
        let viewModel = ServerStatusViewModel()

        await viewModel.check(using: MockHealthService(result: false))

        #expect(viewModel.state == .down)
    }
}

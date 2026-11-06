import Foundation

/// 테스트에서 네트워크를 교체할 수 있도록 URLSession을 감싼 전송 계층.
protocol HTTPTransport: Sendable {
    func send(_ request: URLRequest) async throws -> (Data, URLResponse)
}

struct URLSessionTransport: HTTPTransport {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func send(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}

enum APIError: Error, Equatable {
    /// 서버가 표준 오류 본문({"code": ...})을 보낸 경우 code를 담는다.
    case http(status: Int, code: String?)
    case invalidResponse
    case decoding
    case transport
}

/// 서버 표준 오류 응답 (API_CONTRACT.md 참고)
struct ServerErrorBody: Decodable, Sendable {
    let code: String
    let message: String?
}

struct APIClient: Sendable {
    let baseURL: URL
    let transport: any HTTPTransport

    init(baseURL: URL, transport: any HTTPTransport = URLSessionTransport()) {
        self.baseURL = baseURL
        self.transport = transport
    }

    func get<Response: Decodable>(_ path: String, as type: Response.Type = Response.self) async throws -> Response {
        var request = URLRequest(url: baseURL.appending(path: path))
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return try await perform(request)
    }

    private func perform<Response: Decodable>(_ request: URLRequest) async throws -> Response {
        let result: (Data, URLResponse)
        do {
            result = try await transport.send(request)
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            throw APIError.transport
        }

        let (data, response) = result
        guard let http = response as? HTTPURLResponse else { throw APIError.invalidResponse }

        guard (200..<300).contains(http.statusCode) else {
            let body = try? JSONDecoder().decode(ServerErrorBody.self, from: data)
            throw APIError.http(status: http.statusCode, code: body?.code)
        }

        do {
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            throw APIError.decoding
        }
    }
}

import Foundation

/// Info.plist(→ Configs/*.xcconfig)에서 읽는 환경 설정.
struct AppConfig: Sendable, Equatable {
    let apiBaseURL: URL
    let useMockServices: Bool

    static let fallbackBaseURL = URL(string: "http://localhost:8080")!

    static func load(from bundle: Bundle = .main) -> AppConfig {
        load(from: bundle.infoDictionary ?? [:])
    }

    static func load(from info: [String: Any]) -> AppConfig {
        let rawURL = (info["API_BASE_URL"] as? String) ?? ""
        let url = URL(string: rawURL).flatMap { $0.scheme == nil ? nil : $0 } ?? fallbackBaseURL
        let useMock = ((info["USE_MOCK_SERVICES"] as? String) ?? "").uppercased() == "YES"
        return AppConfig(apiBaseURL: url, useMockServices: useMock)
    }
}

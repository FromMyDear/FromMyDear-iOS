import Foundation
import Testing
@testable import FromMyDear

struct AppConfigTests {
    @Test func readsValuesFromInfoDictionary() {
        let config = AppConfig.load(from: [
            "API_BASE_URL": "https://api.example.com",
            "USE_MOCK_SERVICES": "YES",
        ])

        #expect(config.apiBaseURL == URL(string: "https://api.example.com")!)
        #expect(config.useMockServices)
    }

    @Test func fallsBackWhenValuesAreMissingOrInvalid() {
        let config = AppConfig.load(from: ["API_BASE_URL": "not a url"])

        #expect(config.apiBaseURL == AppConfig.fallbackBaseURL)
        #expect(config.useMockServices == false)
    }
}

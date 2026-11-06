import SwiftUI

@main
struct FromMyDearApp: App {
    @State private var environment = AppEnvironment(config: .load())

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(environment)
        }
    }
}

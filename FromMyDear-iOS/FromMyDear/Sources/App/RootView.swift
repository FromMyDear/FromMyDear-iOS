import SwiftUI

enum AppTab: Hashable, CaseIterable {
    case today, schedule, together, records

    var title: String {
        switch self {
        case .today: "오늘"
        case .schedule: "일정"
        case .together: "함께"
        case .records: "기록"
        }
    }

    var symbol: String {
        switch self {
        case .today: "sun.max"
        case .schedule: "calendar"
        case .together: "checklist"
        case .records: "book.closed"
        }
    }
}

struct RootView: View {
    @State private var selection: AppTab = .today

    var body: some View {
        TabView(selection: $selection) {
            TodayView()
                .tabItem { Label(AppTab.today.title, systemImage: AppTab.today.symbol) }
                .tag(AppTab.today)

            ScheduleView()
                .tabItem { Label(AppTab.schedule.title, systemImage: AppTab.schedule.symbol) }
                .tag(AppTab.schedule)

            TogetherView()
                .tabItem { Label(AppTab.together.title, systemImage: AppTab.together.symbol) }
                .tag(AppTab.together)

            RecordsView()
                .tabItem { Label(AppTab.records.title, systemImage: AppTab.records.symbol) }
                .tag(AppTab.records)
        }
        .tint(DSColor.accent)
    }
}

#Preview {
    RootView()
        .environment(AppEnvironment(config: AppConfig(apiBaseURL: URL(string: "http://localhost:8080")!, useMockServices: true)))
}

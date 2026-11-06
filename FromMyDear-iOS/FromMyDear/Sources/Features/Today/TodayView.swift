import SwiftUI

struct TodayView: View {
    @State private var isSettingsPresented = false

    var body: some View {
        NavigationStack {
            EmptyStateView(
                title: "아직 오늘의 영상이 없어요",
                systemImage: "video",
                message: "서로의 하루가 올라오면 여기에 시간순으로 보여요."
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(DSColor.background)
            .navigationTitle(AppTab.today.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSettingsPresented = true
                    } label: {
                        Image(systemName: "gearshape")
                            .frame(minWidth: DSLayout.minTouchTarget, minHeight: DSLayout.minTouchTarget)
                    }
                    .accessibilityLabel("설정")
                }
            }
            .sheet(isPresented: $isSettingsPresented) {
                SettingsView()
            }
        }
    }
}

#Preview {
    TodayView()
        .environment(AppEnvironment(config: AppConfig(apiBaseURL: AppConfig.fallbackBaseURL, useMockServices: true)))
}

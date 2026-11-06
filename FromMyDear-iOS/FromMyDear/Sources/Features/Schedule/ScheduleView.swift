import SwiftUI

struct ScheduleView: View {
    var body: some View {
        NavigationStack {
            EmptyStateView(
                title: "등록된 일정이 없어요",
                systemImage: "calendar",
                message: "함께할 일정과 여행을 이곳에서 준비해요."
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(DSColor.background)
            .navigationTitle(AppTab.schedule.title)
        }
    }
}

#Preview {
    ScheduleView()
}

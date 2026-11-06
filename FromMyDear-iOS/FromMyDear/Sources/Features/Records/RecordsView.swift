import SwiftUI

struct RecordsView: View {
    var body: some View {
        NavigationStack {
            EmptyStateView(
                title: "아직 남긴 기록이 없어요",
                systemImage: "book.closed",
                message: "일기는 기본적으로 나만 볼 수 있어요. 공개할 때만 상대에게 보여요."
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(DSColor.background)
            .navigationTitle(AppTab.records.title)
        }
    }
}

#Preview {
    RecordsView()
}

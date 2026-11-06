import SwiftUI

struct TogetherView: View {
    var body: some View {
        NavigationStack {
            EmptyStateView(
                title: "함께 쓰는 목록이 없어요",
                systemImage: "checklist",
                message: "장보기와 할 일을 두 사람이 같이 체크할 수 있어요."
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(DSColor.background)
            .navigationTitle(AppTab.together.title)
        }
    }
}

#Preview {
    TogetherView()
}

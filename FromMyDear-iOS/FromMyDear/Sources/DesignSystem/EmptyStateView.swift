import SwiftUI

/// 빈 상태 공통 컴포넌트. 문구는 재촉·죄책감을 주지 않도록 쓴다.
struct EmptyStateView: View {
    let title: String
    let systemImage: String
    let message: String

    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: systemImage)
        } description: {
            Text(message)
        }
        .foregroundStyle(DSColor.textPrimary)
    }
}

#Preview {
    EmptyStateView(title: "아직 영상이 없어요", systemImage: "video", message: "오늘의 순간을 짧게 남겨보세요.")
}

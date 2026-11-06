import SwiftUI

struct SettingsView: View {
    @Environment(AppEnvironment.self) private var environment
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ServerStatusViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section("개발 정보") {
                    LabeledContent("데이터", value: environment.config.useMockServices ? "Mock" : "실제 서버")
                    LabeledContent("서버 주소", value: environment.config.apiBaseURL.absoluteString)
                    HStack {
                        Text("서버 상태")
                        Spacer()
                        statusLabel
                    }
                    Button("다시 확인") {
                        Task { await viewModel.check(using: environment.healthService) }
                    }
                    .disabled(viewModel.state == .loading)
                }
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("닫기") { dismiss() }
                }
            }
            // 화면이 사라지면 .task 작업은 자동 취소된다.
            .task { await viewModel.check(using: environment.healthService) }
        }
    }

    @ViewBuilder
    private var statusLabel: some View {
        switch viewModel.state {
        case .idle:
            Text("-").foregroundStyle(DSColor.textSecondary)
        case .loading:
            ProgressView()
        case .up:
            Label("정상", systemImage: "checkmark.circle.fill").foregroundStyle(DSColor.success)
        case .down:
            Label("연결 안 됨", systemImage: "exclamationmark.triangle.fill").foregroundStyle(DSColor.error)
        }
    }
}

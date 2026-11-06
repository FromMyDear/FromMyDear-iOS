import ProjectDescription

let appName = "FromMyDear"
let bundleIdPrefix = "com.frommydear"
// iOS 17: @Observable(Observation), ContentUnavailableView를 쓰기 위한 최소 버전
let deploymentTargets: DeploymentTargets = .iOS("17.0")

let project = Project(
    name: appName,
    options: .options(
        defaultKnownRegions: ["ko", "en"],
        developmentRegion: "ko"
    ),
    settings: .settings(
        base: [
            "SWIFT_VERSION": "6.0",
            "ENABLE_USER_SCRIPT_SANDBOXING": "YES",
        ],
        configurations: [
            .debug(name: .debug, xcconfig: "Configs/Debug.xcconfig"),
            .release(name: .release, xcconfig: "Configs/Release.xcconfig"),
        ]
    ),
    targets: [
        .target(
            name: appName,
            destinations: [.iPhone],
            product: .app,
            bundleId: "\(bundleIdPrefix).ios",
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
                "UILaunchScreen": [:],
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                // 환경별 값 (Configs/*.xcconfig)
                "API_BASE_URL": "$(API_BASE_URL)",
                "USE_MOCK_SERVICES": "$(USE_MOCK_SERVICES)",
                // 로컬 서버(http://localhost)만 허용
                "NSAppTransportSecurity": ["NSAllowsLocalNetworking": true],
                // 권한은 기능 진입 시점에 요청한다
                "NSCameraUsageDescription": "일상 영상을 촬영하려면 카메라 접근이 필요해요.",
                "NSMicrophoneUsageDescription": "영상에 소리를 담으려면 마이크 접근이 필요해요.",
                "NSPhotoLibraryUsageDescription": "보관함의 영상과 사진을 선택하려면 사진 접근이 필요해요.",
            ]),
            sources: ["FromMyDear/Sources/**"],
            resources: ["FromMyDear/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "\(appName)Tests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "\(bundleIdPrefix).ios.tests",
            deploymentTargets: deploymentTargets,
            infoPlist: .default,
            sources: ["FromMyDear/Tests/**"],
            dependencies: [.target(name: appName)]
        ),
    ]
)

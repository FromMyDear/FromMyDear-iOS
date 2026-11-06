# FromMyDear-iOS

Client application for From My Dear — A warm, intimate space to store & share heartfelt feelings and cherished memories.

## 기술 스택

| 항목 | 선택 | 이유 |
| --- | --- | --- |
| UI | SwiftUI, Swift 6 | |
| 최소 지원 | iOS 17.0 | `@Observable`, `ContentUnavailableView` 사용 |
| 빌드 도구 | Xcode 26 이상 | 2026-04-28부터 App Store 업로드 필수 요건 |
| 프로젝트 관리 | Tuist 4 (mise로 설치) | `.xcodeproj` 충돌 없이 코드로 관리 |
| 테스트 | Swift Testing | |

## 처음 실행하기

```bash
# 1. mise 설치 (한 번만)
curl https://mise.run | sh

# 2. Tuist 설치 + 외부 패키지 + 프로젝트 생성
mise install
tuist install
tuist generate        # FromMyDear.xcworkspace가 열림
```

Xcode에서 `FromMyDear` 스킴을 선택하고 시뮬레이터로 실행합니다.

## Mock ↔ 실제 서버 전환

`Configs/Debug.xcconfig`의 값을 바꾸고 다시 빌드합니다.

| 값 | 동작 |
| --- | --- |
| `USE_MOCK_SERVICES = YES` | 서버 없이 Mock 데이터로 실행 (기본) |
| `USE_MOCK_SERVICES = NO` | `API_BASE_URL`(기본 `http://localhost:8080`)의 실제 서버 호출 |

실제 서버 연결은 오늘 탭 → 설정(톱니바퀴) → 서버 상태에서 확인할 수 있습니다.

## 테스트

```bash
tuist test FromMyDear
```

## 폴더 구조

```
Project.swift              # 타깃·설정 정의 (여기를 고친다)
Tuist.swift / Tuist/Package.swift   # Tuist 설정, 외부 패키지
Configs/                   # Debug·Release 환경 값
FromMyDear/
├── Sources/
│   ├── App/               # 앱 진입점, 탭 구조, 의존성 조립(AppEnvironment)
│   ├── Core/              # Config, Network(APIClient), Services(프로토콜 + Mock + Live)
│   ├── DesignSystem/      # 색·간격·모서리 토큰, 공통 컴포넌트
│   └── Features/          # Today, Schedule, Together, Records, Settings
├── Resources/             # Assets
└── Tests/
```

## 남은 작업

- [ ] 앱 아이콘 이미지, 번들 ID·팀 서명 설정
- [ ] 디자인 시안 확정 후 토큰 값 교체, 색 대비 검증
- [ ] 인증(Sign in with Apple, Keychain 토큰 저장), 커플 연결 화면
- [ ] 운영 `API_BASE_URL` 설정

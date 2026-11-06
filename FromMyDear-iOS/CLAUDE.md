# 작업 지침 (AI·사람 공통)

- 기준 문서: FromMyDear-docs 레포의 PRD.md, SCREEN_SPEC.md, API_CONTRACT.md. 충돌하면 임의로 바꾸지 말고 이슈로 남긴다.
- 프로젝트 파일은 Tuist로 생성한다. `.xcodeproj`를 직접 수정·커밋하지 않고 `Project.swift`를 고친다.
- 외부 패키지는 `Tuist/Package.swift`에만 추가하고, 꼭 필요할 때만 쓴다.
- 폴더: `Sources/App`(진입점·조립), `Core`(설정·네트워크·서비스), `DesignSystem`(토큰·공통 컴포넌트), `Features/<기능>`.
- 화면 상태와 로직은 `@MainActor @Observable` ViewModel에 두고 View는 그리기만 한다.
- 서비스는 프로토콜 + Mock + Live로 만들고 `AppEnvironment`에서 `USE_MOCK_SERVICES`로 교체한다.
- 색·간격·모서리는 `DSColor`, `DSSpacing`, `DSRadius` 토큰만 사용한다.
- 토큰은 Keychain에 저장하고, 개인 데이터를 로그로 출력하지 않는다.
- 변경 후 `tuist test`를 통과시킨다.

// swift-tools-version: 6.0
// 외부 Swift 패키지는 여기에만 추가하고 `tuist install`로 받는다.
// 원칙: 꼭 필요한 경우에만 추가한다 (기본은 Apple 프레임워크).
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "FromMyDear",
    dependencies: []
)

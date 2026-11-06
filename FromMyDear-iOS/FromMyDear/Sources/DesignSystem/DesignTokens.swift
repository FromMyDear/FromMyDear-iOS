import SwiftUI
import UIKit

// 디자인 시스템 초안 토큰. 디자인 시안 확정 후 값만 교체한다.
// 색상은 접근성 대비(본문 4.5:1 이상) 검증 전의 임시값이다.

enum DSColor {
    static let background = Color.dynamic(light: 0xFAF6EF, dark: 0x1B1A18)   // 따뜻한 아이보리
    static let surface = Color.dynamic(light: 0xFFFFFF, dark: 0x262422)
    static let textPrimary = Color.dynamic(light: 0x2B2A28, dark: 0xF2EEE8)  // 짙은 차콜
    static let textSecondary = Color.dynamic(light: 0x6B6762, dark: 0xB3ADA5)
    static let accent = Color.dynamic(light: 0xC8614E, dark: 0xE88A76)       // 차분한 코랄
    static let support = Color.dynamic(light: 0x7A9179, dark: 0x9DB39B)      // 세이지
    static let separator = Color.dynamic(light: 0xE6E0D6, dark: 0x3A3733)

    // 의미 색상
    static let success = Color.dynamic(light: 0x2E7D4F, dark: 0x6CC490)
    static let warning = Color.dynamic(light: 0xA86A00, dark: 0xF0B44C)
    static let error = Color.dynamic(light: 0xB3261E, dark: 0xF2867D)
}

enum DSSpacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let s: CGFloat = 12
    static let m: CGFloat = 16
    static let l: CGFloat = 24
    static let xl: CGFloat = 32
}

enum DSRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 20
}

enum DSLayout {
    /// Apple HIG 최소 터치 영역
    static let minTouchTarget: CGFloat = 44
}

extension Color {
    /// 라이트·다크 모드에 따라 바뀌는 색상
    static func dynamic(light: UInt32, dark: UInt32) -> Color {
        Color(uiColor: UIColor { traits in
            UIColor(rgb: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

extension UIColor {
    convenience init(rgb: UInt32) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: 1
        )
    }
}

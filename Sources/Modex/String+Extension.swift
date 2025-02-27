import Foundation

public extension String  {
    
    /// 문자열이 숫자로 변환 가능한지 확인하는 속성
    ///
    /// 이 속성은 문자열이 `Double`로 변환 가능한지를 검사하여 숫자 여부를 반환합니다.
    ///
    /// - Returns: 문자열이 숫자로 변환 가능하면 `true`, 그렇지 않으면 `false`
    ///
    /// ## 예제
    /// ```swift
    /// print("123".isNumeric)      // true
    /// print("123.45".isNumeric)   // true
    /// print("abc".isNumeric)      // false
    /// print("123abc".isNumeric)   // false
    /// print("".isNumeric)         // false
    /// ```
    var isNumeric: Bool {
        return Double(self) != nil
    }

    /// 전화번호에서 특수문자와 공백을 제거한 문자열을 반환하는 속성
    ///
    /// 이 속성은 문자열에서 `+`, `-`, 공백 및 줄 바꿈 문자를 제거하여
    /// 순수한 숫자로만 이루어진 전화번호 문자열을 반환합니다.
    ///
    /// - Returns: `+`, `-`, 공백이 제거된 문자열
    ///
    /// ## 예제
    /// ```swift
    /// print("+1 234-567-890".phoneNumber) // "1234567890"
    /// print("  010-1234-5678  ".phoneNumber) // "01012345678"
    /// print("+82 10 9876-5432".phoneNumber) // "821098765432"
    /// ```
    var phoneNumber: String {
        self
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "-", with: "")
            .components(separatedBy: .whitespacesAndNewlines)
            .joined()
    }
    
}

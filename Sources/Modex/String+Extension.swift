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

    var phoneNumber: String {
        self
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "-", with: "")
            .components(separatedBy: .whitespacesAndNewlines)
            .joined()
    }
    
}

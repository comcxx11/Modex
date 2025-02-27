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
    
    /// 문자열의 앞뒤 공백 및 개행 문자 제거
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 문자열에서 모든 공백 제거
    var withoutSpaces: String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    /// 숫자만 남기고 문자 제거
    var onlyNumbers: String {
        self.filter { $0.isNumber }
    }
    
    /// 알파벳(영어)만 남기고 숫자 및 특수 문자 제거
    var onlyLetters: String {
        self.filter { $0.isLetter }
    }
    
    /// 문자열을 특정 길이로 자르고 "..." 추가 (기본값 10자)
    func truncated(to length: Int = 10, trailing: String = "...") -> String {
        return self.count > length ? String(self.prefix(length)) + trailing : self
    }
    
    /// 특정 문자열 포함 여부 (대소문자 무시)
    func contains(_ substring: String, caseInsensitive: Bool = true) -> Bool {
        return caseInsensitive
            ? self.range(of: substring, options: .caseInsensitive) != nil
            : self.range(of: substring) != nil
    }
    
    /// 특정 문자열을 다른 문자열로 치환
    func replacing(_ target: String, with replacement: String) -> String {
        return self.replacingOccurrences(of: target, with: replacement)
    }
    
    /// 이메일 형식 유효성 검사
    var isValidEmail: Bool {
        let regex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return self.range(of: regex, options: .regularExpression) != nil
    }
    
    /// URL 형식 유효성 검사
    var isValidURL: Bool {
        return URL(string: self) != nil
    }
    
    /// 한글 포함 여부 확인
    var containsKorean: Bool {
        return self.range(of: #"[가-힣]"#, options: .regularExpression) != nil
    }
    
    /// 영문 포함 여부 확인
    var containsEnglish: Bool {
        return self.range(of: #"[A-Za-z]"#, options: .regularExpression) != nil
    }
    
    /// 숫자 포함 여부 확인
    var containsNumber: Bool {
        return self.range(of: #"[0-9]"#, options: .regularExpression) != nil
    }
    
    /// 랜덤 문자열 생성 (기본 8자리)
    static func randomString(length: Int = 8) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
    
}

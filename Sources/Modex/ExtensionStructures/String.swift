import Foundation

public extension String {
    
    /// 현재 문자열을 로컬라이징된 문자열로 변환합니다.
    ///
    /// `String(localized:)`을 사용하여 `Localizable.strings` 파일에서 해당 키에 해당하는 번역된 문자열을 반환합니다.
    ///
    /// ### 예제
    /// ```swift
    /// let greeting = "hello".localized
    /// print(greeting)  // "こんにちは" (설정 언어가 일본어일 경우)
    /// ```
    ///
    /// - Returns: 번역된 문자열 (해당 키가 없으면 원본 문자열 반환)
    var localized: String {
        String(localized: String.LocalizationValue(self))
    }
    
    // MARK: - 문자 변환 및 정리
    
    /// 앞뒤 공백 및 개행 문자 제거
    ///
    /// ### 예제
    /// ```swift
    /// let text = "  Hello, World!  \n"
    /// print(text.trimmed)  // "Hello, World!"
    /// ```
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 모든 공백 제거
    ///
    /// ### 예제
    /// ```swift
    /// let text = "Hello World!"
    /// print(text.withoutSpaces)  // "HelloWorld!"
    /// ```
    var withoutSpaces: String {
        replacingOccurrences(of: " ", with: "")
    }
    
    /// 특정 문자들을 제거한 새로운 문자열 반환
    ///
    /// - Parameter characters: 제거할 문자 세트
    /// - Returns: 정리된 문자열
    ///
    /// ### 예제
    /// ```swift
    /// let text = "Hello, World!"
    /// print(text.removingCharacters(in: .punctuationCharacters))  // "Hello World"
    /// ```
    func removingCharacters(in characters: CharacterSet) -> String {
        components(separatedBy: characters).joined()
    }
    
    /// 문자열을 CamelCase로 변환
    ///
    /// ### 예제
    /// ```swift
    /// let text = "hello world example"
    /// print(text.camelCased)  // "helloWorldExample"
    /// ```
    var camelCased: String {
        self.lowercased()
            .split(separator: " ")
            .enumerated()
            .map { $0.offset == 0 ? $0.element.lowercased() : $0.element.capitalized }
            .joined()
    }
    
    /// 문자열을 snake_case로 변환
    ///
    /// ### 예제
    /// ```swift
    /// let text = "Hello World Example"
    /// print(text.snakeCased)  // "hello_world_example"
    /// ```
    var snakeCased: String {
        self.lowercased()
            .replacingOccurrences(of: " ", with: "_")
    }
    
    /// 문자열을 거꾸로 반환
    ///
    /// ### 예제
    /// ```swift
    /// let text = "Hello"
    /// print(text.reversedString)  // "olleH"
    /// ```
    var reversedString: String {
        String(self.reversed())
    }
    
    /// 문자열의 첫 글자를 대문자로 변환
    ///
    /// ### 예제
    /// ```swift
    /// let text = "hello"
    /// print(text.capitalizingFirstLetter)  // "Hello"
    /// ```
    var capitalizingFirstLetter: String {
        prefix(1).uppercased() + dropFirst()
    }
    
    // MARK: - 문자열 검증
    
    /// 문자열이 숫자로 변환 가능한지 확인
    ///
    /// `Double(self)`보다 정확한 검사 (`NumberFormatter` 활용)
    ///
    /// ### 예제
    /// ```swift
    /// print("123".isNumeric)   // true
    /// print("12.34".isNumeric) // true
    /// print("abc".isNumeric)   // false
    /// ```
    var isNumeric: Bool {
        let formatter = NumberFormatter()
        return formatter.number(from: self) != nil
    }
    
    /// 이메일 형식 유효성 검사
    ///
    /// ### 예제
    /// ```swift
    /// print("test@example.com".isValidEmail)  // true
    /// print("invalid-email".isValidEmail)    // false
    /// ```
    var isValidEmail: Bool {
        let regex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return range(of: regex, options: .regularExpression) != nil
    }
    
    /// URL 형식 유효성 검사
    ///
    /// ### 예제
    /// ```swift
    /// print("https://www.google.com".isValidURL)  // true
    /// print("not a url".isValidURL)              // false
    /// ```
    var isValidURL: Bool {
        return URL(string: self) != nil
    }
    
    /// 한글 포함 여부 확인
    ///
    /// ### 예제
    /// ```swift
    /// print("안녕하세요".containsKorean) // true
    /// print("Hello".containsKorean)     // false
    /// ```
    var containsKorean: Bool {
        return range(of: #"[가-힣]"#, options: .regularExpression) != nil
    }
    
    /// 숫자 포함 여부 확인
    ///
    /// ### 예제
    /// ```swift
    /// print("Swift5".containsNumber)  // true
    /// print("Swift".containsNumber)   // false
    /// ```
    var containsNumber: Bool {
        return range(of: #"[0-9]"#, options: .regularExpression) != nil
    }
    
    // MARK: - 문자열 변환
    
    /// 전화번호에서 특수문자와 공백을 제거한 문자열을 반환
    ///
    /// `+`, `-`, 공백 및 개행 문자를 제거하여 숫자로만 이루어진 전화번호 문자열 반환
    ///
    /// ### 예제
    /// ```swift
    /// let phone = "+1 234-567-890"
    /// print(phone.phoneNumber)  // "1234567890"
    /// ```
    var phoneNumber: String {
        self
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "-", with: "")
            .components(separatedBy: .whitespacesAndNewlines)
            .joined()
    }
    
    /// 숫자만 남기고 문자 제거
    ///
    /// ### 예제
    /// ```swift
    /// print("abc123".onlyNumbers)  // "123"
    /// ```
    var onlyNumbers: String {
        self.filter { $0.isNumber }
    }
    
    /// 문자열을 특정 길이로 자르고 "..." 추가 (기본값 10자)
    ///
    /// ### 예제
    /// ```swift
    /// let text = "Hello, this is a long text"
    /// print(text.truncated(to: 10))  // "Hello, thi..."
    /// ```
    func truncated(to length: Int = 10, trailing: String = "...") -> String {
        return self.count > length ? String(self.prefix(length)) + trailing : self
    }
    
    // MARK: - 문자열 마스킹 (Masking)
    
    /// 문자열 끝에서 `count`개의 문자를 `*`로 마스킹
    ///
    /// ### 예제
    /// ```swift
    /// print("1234567890".maskingLast(4))  // "123456****"
    /// ```
    func maskingLast(_ count: Int) -> String {
        guard count > 0, self.count > count else { return self }
        let visible = self.prefix(self.count - count)
        let masked = String(repeating: "*", count: count)
        return visible + masked
    }
    
    /// 지정한 범위를 특정 문자로 마스킹
    ///
    /// ### 예제
    /// ```swift
    /// print("hello world".maskingRange(2..<7, with: "#"))  // "he#####rld"
    /// ```
    func maskingRange(_ range: Range<Int>, with maskCharacter: Character = "*") -> String {
        guard range.lowerBound >= 0, range.upperBound <= self.count else { return self }
        let start = self.prefix(range.lowerBound)
        let masked = String(repeating: maskCharacter, count: range.count)
        let end = self.suffix(self.count - range.upperBound)
        return start + masked + end
    }
    
    /// 이메일을 `abc***@domain.com` 형태로 마스킹
    ///
    /// ### 예제
    /// ```swift
    /// print("test@example.com".maskingEmail())  // "te**@example.com"
    /// ```
    func maskingEmail() -> String {
        let components = self.split(separator: "@")
        guard components.count == 2, let first = components.first else { return self }
        
        let visibleCount = max(1, first.count / 2)
        let maskedPart = String(repeating: "*", count: first.count - visibleCount)
        return first.prefix(visibleCount) + maskedPart + "@" + components.last!
    }
    
    /// 전화번호를 `010-****-5678` 형태로 마스킹
    ///
    /// ### 예제
    /// ```swift
    /// print("010-1234-5678".maskingPhone())  // "010-****-5678"
    /// ```
    func maskingPhone() -> String {
        let numbersOnly = self.onlyNumbers
        guard numbersOnly.count >= 7 else { return self }
        
        let prefix = numbersOnly.prefix(3) // 지역번호 또는 국가 코드
        let middleMasked = String(repeating: "*", count: 4)
        let suffix = numbersOnly.suffix(4) // 마지막 4자리
        
        return "\(prefix)-\(middleMasked)-\(suffix)"
    }
    
    // MARK: - 기타 기능
    
    /// 문자열 내 단어 개수 반환
    ///
    /// ### 예제
    /// ```swift
    /// let text = "Hello world, Swift is awesome!"
    /// print(text.wordCount)  // 5
    /// ```
    var wordCount: Int {
        let words = self.split { $0.isWhitespace || $0.isNewline }
        return words.count
    }
    
    /// 랜덤 문자열 생성 (기본 8자리)
    ///
    /// ### 예제
    /// ```swift
    /// let randomStr = String.randomString(length: 12)
    /// print(randomStr)  // "A1b2C3d4E5F6"
    /// ```
    static func randomString(length: Int = 8) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
    
}

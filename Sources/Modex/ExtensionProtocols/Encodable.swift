//
//  Encodable+Extension.swift
//  Modex
//
//  Created by seojin on 2/28/25.
//
import Foundation

public extension Encodable {
    
    /// 객체를 JSON 데이터 (`Data`)로 변환
    ///
    /// ### 예제
    /// ```swift
    /// let user = User(name: "Alice", age: 25)
    /// let jsonData = user.toJsonData()
    /// ```
    func toJsonData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    /// 객체를 JSON 문자열 (`String`)로 변환 (pretty-printed 옵션 지원)
    ///
    /// ### 예제
    /// ```swift
    /// let jsonString = user.toJsonString(prettyPrinted: true)
    /// ```
    func toJsonString(prettyPrinted: Bool = false) -> String? {
        let encoder = JSONEncoder()
        if prettyPrinted {
            encoder.outputFormatting = .prettyPrinted
        }
        guard let jsonData = try? encoder.encode(self) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    /// 객체를 JSON 딕셔너리 (`[String: Any]`)로 변환
    ///
    /// ### 예제
    /// ```swift
    /// let dict = user.toDictionary()
    /// print(dict?["name"])  // "Alice"
    /// ```
    func toDictionary() -> [String: Any]? {
        guard let jsonData = toJsonData() else { return nil }
        return (try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)) as? [String: Any]
    }
    
    /// 객체를 로컬 파일에 JSON 형식으로 저장 (`Documents` 폴더에 저장됨)
    ///
    /// ### 예제
    /// ```swift
    /// user.saveToFile(fileName: "user.json")
    /// ```
    func saveToFile(fileName: String) {
        guard let jsonData = toJsonData() else { return }
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let fileURL = urls.first?.appendingPathComponent(fileName) {
            do {
                try jsonData.write(to: fileURL)
                print("✅ 저장 성공: \(fileURL)")
            } catch {
                print("❌ 파일 저장 실패: \(error)")
            }
        }
    }
    
    /// 객체를 Plist (`.plist`) 데이터로 변환
    ///
    /// ### 예제
    /// ```swift
    /// let plistData = user.toPlistData()
    /// ```
    func toPlistData() -> Data? {
        return try? PropertyListEncoder().encode(self)
    }
    
    /// 객체를 Plist (`.plist`) 문자열로 변환
    ///
    /// ### 예제
    /// ```swift
    /// let plistString = user.toPlistString()
    /// ```
    func toPlistString() -> String? {
        guard let plistData = toPlistData() else { return nil }
        return String(data: plistData, encoding: .utf8)
    }
    
    /// JSON을 Base64 인코딩된 문자열로 변환
    ///
    /// ### 예제
    /// ```swift
    /// let base64Json = user.toBase64Json()
    /// ```
    func toBase64Json() -> String? {
        guard let jsonData = toJsonData() else { return nil }
        return jsonData.base64EncodedString()
    }
}

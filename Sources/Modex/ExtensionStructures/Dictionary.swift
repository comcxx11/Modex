//
//  Dictionary+Extension.swift
//
//
//  Created by SEOJIN HONG on 2023/03/23.
//

import Foundation

public extension Dictionary {
    
    /// 다른 Dictionary의 내용을 현재 Dictionary에 병합합니다.
    /// - Parameter other: 병합할 Dictionary
    ///
    /// ### 예제
    /// ```swift
    /// var dict1 = ["a": 1, "b": 2]
    /// let dict2 = ["b": 3, "c": 4]
    /// dict1.update(other: dict2)
    /// print(dict1) // ["a": 1, "b": 3, "c": 4]
    /// ```
    mutating func update(other: Dictionary) {
        self.merge(other) { (_, new) in new }
    }
    
    /// JSON 형식으로 print (디버깅 용도)
    func toJson() {
        print(self.toJsonStr(.prettyPrinted))
    }
    
    /// Dictionary를 JSON 문자열로 변환
    /// - Parameter options: JSONSerialization 옵션 (기본값: [])
    /// - Returns: JSON 문자열
    ///
    /// ### 예제
    /// ```swift
    /// let dict = ["name": "John", "age": 30]
    /// let jsonString = dict.toJsonStr(.prettyPrinted)
    /// print(jsonString)
    /// ```
    func toJsonStr(_ options: JSONSerialization.WritingOptions = []) -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return "{}"
        }
        return jsonString
    }
}

public extension Dictionary where Key == String {
    
    /// Dictionary를 JSON Data로 변환
    /// - Parameter options: JSONSerialization 옵션 (기본값: [])
    /// - Returns: JSON Data
    ///
    /// ### 예제
    /// ```swift
    /// let dict = ["name": "Alice", "age": "25"]
    /// let jsonData = dict.toJsonData()
    /// print(jsonData) // Data 타입 출력
    /// ```
    func toJsonData(_ options: JSONSerialization.WritingOptions = []) -> Data {
        return (try? JSONSerialization.data(withJSONObject: self, options: options)) ?? Data()
    }
    
    /// Dictionary를 Query String 형태로 변환
    /// - Returns: URL Query String
    ///
    /// ### 예제
    /// ```swift
    /// let params = ["name": "Alice", "age": "25"]
    /// let query = params.toQuery
    /// print(query) // "name=Alice&age=25"
    /// ```
    var toQuery: String {
        self.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
}

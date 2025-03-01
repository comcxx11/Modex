//
//  Collection+Extension.swift
//  Modex
//
//  Created by seojin on 2/28/25.
//

import Foundation

/**
 * Array, Dictionary, Set, String 등의 다양한 데이터 타입이 Collection 프로토콜을 준수
 */
public extension Collection {
    
    // MARK: - 안전한 접근
    
    /// 컬렉션이 비어있지 않은지 확인 (isEmpty의 반대)
    ///
    /// ### 예제
    /// ```swift
    /// let items = [1, 2, 3]
    /// print(items.isNotEmpty)  // true
    /// ```
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    /// 주어진 인덱스가 유효한지 확인
    ///
    /// ### 예제
    /// ```swift
    /// let array = [10, 20, 30]
    /// print(array.safeIndex(1))  // true
    /// print(array.safeIndex(5))  // false
    /// ```
    func safeIndex(_ index: Index) -> Bool {
        return indices.contains(index)
    }
    
    /// 컬렉션을 지정된 크기로 나누어 배열로 반환
    ///
    /// - Parameter size: 각 청크의 크기
    /// - Returns: 나눠진 요소들의 배열
    ///
    /// ### 예제
    /// ```swift
    /// let numbers = [1, 2, 3, 4, 5, 6, 7]
    /// print(numbers.chunked(into: 3))  // [[1, 2, 3], [4, 5, 6], [7]]
    ///
    /// let string = "HelloWorld"
    /// print(string.chunked(into: 3))  // ["Hel", "loW", "orl", "d"]
    /// ```
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [] } // 크기가 0 이하이면 빈 배열 반환
        
        var result: [[Element]] = [] // 올바른 타입을 사용
        var start = startIndex
        
        while start < endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            result.append(Array(self[start..<end])) // ✅ [Element]로 변환 후 저장
            start = end
        }
        
        return result
    }
    
    /// 컬렉션에서 랜덤한 요소 여러 개 가져오기
    ///
    /// ### 예제
    /// ```swift
    /// let numbers = [1, 2, 3, 4, 5]
    /// print(numbers.randomElements(3))  // 예: [4, 1, 5]
    /// ```
    func randomElements(_ count: Int) -> [Element] {
        return Array(shuffled().prefix(count))
    }
    
    /// 특정 조건을 만족하는 요소 개수 반환
    ///
    /// ### 예제
    /// ```swift
    /// let numbers = [1, 2, 3, 4, 5]
    /// print(numbers.count(where: { $0 % 2 == 0 }))  // 2 (짝수 개수)
    /// ```
    func count(where predicate: (Element) -> Bool) -> Int {
        return filter(predicate).count
    }
    
    /// 특정 조건을 만족하지 않는 첫 번째 요소 찾기
    ///
    /// - Parameter predicate: 제외할 조건
    /// - Returns: 조건을 만족하지 않는 첫 번째 요소 (없다면 `nil`)
    ///
    /// ### 예제
    /// ```swift
    /// let numbers = [2, 4, 6, 7, 8]
    /// print(numbers.first(whereNot: { $0 % 2 == 0 }))  // 7
    /// ```
    func first(whereNot predicate: (Element) -> Bool) -> Element? {
        for element in self {
            if !predicate(element) {
                return element
            }
        }
        return nil
    }
    
    // MARK: - 그룹화
    
    /// 컬렉션을 특정 기준으로 그룹화
    ///
    /// ### 예제
    /// ```swift
    /// struct Person { let name: String, let age: Int }
    /// let people = [Person(name: "Alice", age: 25), Person(name: "Bob", age: 25), Person(name: "Charlie", age: 30)]
    /// let grouped = people.grouped(by: { $0.age })
    /// print(grouped)  // [25: [Alice, Bob], 30: [Charlie]]
    /// ```
    func grouped<T: Hashable>(by keyPath: (Element) -> T) -> [T: [Element]] {
        var dictionary: [T: [Element]] = [:]
        for element in self {
            let key = keyPath(element)
            dictionary[key, default: []].append(element)
        }
        return dictionary
    }
    
    /// 컬렉션에서 안전하게 요소를 가져오는 서브스크립트입니다.
    ///
    /// 인덱스가 유효하면 해당 요소를 반환하고, 범위를 벗어나면 `nil`을 반환합니다.
    ///
    /// ### 사용 예시
    /// ```swift
    /// let numbers = [10, 20, 30, 40]
    ///
    /// print(numbers[safe: 2])  // 출력: Optional(30)
    /// print(numbers[safe: 10]) // 출력: nil (Crash 없음)
    ///
    /// let text = "Swift"
    /// print(text[safe: 3] ?? "없음")  // 출력: f
    /// print(text[safe: 10] ?? "없음") // 출력: 없음
    /// ```
    ///
    /// - Parameter index: 접근하려는 인덱스
    /// - Returns: 해당 인덱스의 요소를 반환하거나, 유효하지 않으면 `nil`을 반환
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

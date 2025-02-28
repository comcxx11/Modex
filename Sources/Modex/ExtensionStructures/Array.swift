import Foundation

public extension Array {
    
    /// 배열에서 특정 인덱스의 요소를 안전하게 가져옵니다. (범위를 벗어나면 `nil` 반환)
    /// - Parameter index: 가져올 요소의 인덱스.
    /// - Returns: 유효한 인덱스일 경우 해당 요소를 반환하고, 그렇지 않으면 `nil`
    ///
    /// ### 예제
    /// ```swift
    /// let numbers = [10, 20, 30]
    /// print(numbers.get(1)) // Optional(20)
    /// print(numbers.get(5)) // nil
    /// ```
    func get(_ index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
    /// 배열에서 첫 `count`개의 요소를 반환합니다. (초과 요청 시 가능한 요소만 반환)
    /// - Parameter count: 가져올 요소 개수
    /// - Returns: 첫 `count`개의 요소 배열
    ///
    /// ### 예제
    /// ```swift
    /// let numbers = [1, 2, 3, 4, 5]
    /// print(numbers.firstElements(3)) // [1, 2, 3]
    /// print(numbers.firstElements(10)) // [1, 2, 3, 4, 5]
    /// ```
    func firstElements(_ count: Int) -> [Element] {
        return Array(prefix(count))
    }
    
    /// 배열에서 마지막 `count`개의 요소를 반환합니다. (초과 요청 시 가능한 요소만 반환)
    /// - Parameter count: 가져올 요소 개수
    /// - Returns: 마지막 `count`개의 요소 배열
    func lastElements(_ count: Int) -> [Element] {
        return Array(suffix(count))
    }
    
    /// 배열을 `size` 크기만큼 나누어 배열로 반환합니다.
    /// - Parameter size: 나눌 크기
    /// - Returns: 나눠진 배열의 배열
    ///
    /// ### 예제
    /// ```swift
    /// let numbers = [1, 2, 3, 4, 5, 6, 7]
    /// print(numbers.chunked(into: 3)) // [[1, 2, 3], [4, 5, 6], [7]]
    /// ```
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
    
    /// 배열을 특정 키를 기준으로 그룹화합니다.
    /// - Parameter keyPath: 그룹화 기준 키
    /// - Returns: 그룹화된 딕셔너리
    ///
    /// ### 예제
    /// ```swift
    /// struct Person { let name: String, let age: Int }
    /// let people = [Person(name: "Alice", age: 25), Person(name: "Bob", age: 25), Person(name: "Charlie", age: 30)]
    /// let grouped = people.groupBy { $0.age }
    /// print(grouped) // [25: [Person(name: "Alice", age: 25), Person(name: "Bob", age: 25)], 30: [Person(name: "Charlie", age: 30)]]
    /// ```
    func groupBy<T: Hashable>(_ keyPath: (Element) -> T) -> [T: [Element]] {
        var groupedDict = [T: [Element]]()
        for element in self {
            let key = keyPath(element)
            groupedDict[key, default: []].append(element)
        }
        return groupedDict
    }
}

public extension Array where Element: Hashable {
    
    /// 중복을 제거한 새로운 배열을 반환합니다.
    /// - Returns: 중복이 제거된 배열
    ///
    /// ### 예제
    /// ```swift
    /// let numbers = [1, 2, 2, 3, 3, 4]
    /// print(numbers.removingDuplicates()) // [1, 2, 3, 4]
    /// ```
    func removingDuplicates() -> [Element] {
        return Array(Set(self))
    }
    
    /// 배열에서 중복을 제거합니다. (원본 변경)
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

public extension Array where Element: Equatable {
    
    /// 배열에서 특정 요소가 나타나는 모든 인덱스를 찾습니다.
    /// - Parameter element: 찾고자 하는 요소.
    /// - Returns: 해당 요소가 존재하는 모든 인덱스의 배열.
    func indexes(of element: Element) -> [Int] {
        self.enumerated().compactMap { $0.element == element ? $0.offset : nil }
    }

    /// 배열에서 특정 요소를 제거합니다.
    /// - Parameter element: 제거할 요소
    ///
    /// ### 예제
    /// ```swift
    /// var numbers = [1, 2, 3, 2, 4]
    /// numbers.remove(2)
    /// print(numbers) // [1, 3, 4]
    /// ```
    mutating func remove(_ element: Element) {
        self = self.filter { $0 != element }
    }
}

public extension Array {
    
    /// 배열에서 첫 번째 요소를 안전하게 제거하고 반환합니다.
    /// - Returns: 첫 번째 요소를 반환하거나, 배열이 비어 있으면 `nil`
    ///
    /// ### 예제
    /// ```swift
    /// var numbers = [10, 20, 30]
    /// let removed = numbers.safeRemoveFirst()
    /// print(removed) // Optional(10)
    /// print(numbers) // [20, 30]
    /// ```
    @discardableResult
    mutating func safeRemoveFirst() -> Element? {
        isEmpty ? nil : removeFirst()
    }
    
    /// 배열에서 지정된 개수만큼 요소를 안전하게 제거하고 반환합니다.
    /// - Parameter count: 제거할 요소 개수
    /// - Returns: 제거된 요소가 담긴 배열. 범위를 초과하면 가능한 요소만 반환.
    ///
    /// ### 예제
    /// ```swift
    /// var numbers = [10, 20, 30, 40, 50]
    /// let removed = numbers.safeRemoveItems(count: 3)
    /// print(removed) // [10, 20, 30]
    /// print(numbers) // [40, 50]
    /// ```
    mutating func safeRemoveItems(count: Int) -> [Element] {
        guard count > 0 else { return [] }
        return (0..<Swift.min(count, self.count)).map { _ in safeRemoveFirst()! }
    }
}

import Testing
@testable import Modex

@Test func testBasicMath() {
    let sum = 2 + 3
    #expect(sum == 5)
}

@Test func testStringConcatenation() {
    let result = "Hello, " + "Modex!"
    #expect(result == "Hello, Modex!")
}

@Test func hello() {
    #expect("A" == "A")
}
import Foundation
import Compression

public extension Data {
    
    /// Data를 16진수 문자열로 변환합니다.
    /// - Returns: 변환된 16진수 문자열
    /// - Example:
    /// ```swift
    /// let data = "Hello".data(using: .utf8)!
    /// let hexString = data.toHex
    /// print(hexString) // "48656c6c6f"
    /// ```
    var toHex: String {
        return map { String(format: "%02x", $0) }.joined()
    }
    
    /// 16진수 문자열을 Data로 변환합니다.
    /// - Parameter hexString: 변환할 16진수 문자열
    /// - Example:
    /// ```swift
    /// let data = Data(hexString: "48656c6c6f")
    /// print(String(data: data!, encoding: .utf8)!) // "Hello"
    /// ```
    init?(hexString: String) {
        let length = hexString.count / 2
        var data = Data(capacity: length)
        var index = hexString.startIndex
        
        for _ in 0..<length {
            let nextIndex = hexString.index(index, offsetBy: 2)
            if let byte = UInt8(hexString[index..<nextIndex], radix: 16) {
                data.append(byte)
            } else {
                return nil
            }
            index = nextIndex
        }
        self = data
    }
    
    /// Data를 Base64 문자열로 변환합니다.
    /// - Returns: Base64 인코딩된 문자열
    /// - Example:
    /// ```swift
    /// let data = "Hello".data(using: .utf8)!
    /// let base64String = data.toBase64
    /// print(base64String) // "SGVsbG8="
    /// ```
    var toBase64: String {
        return self.base64EncodedString()
    }
    
    /// Base64 문자열을 Data로 변환합니다.
    /// - Parameter base64: Base64 문자열
    /// - Example:
    /// ```swift
    /// let data = Data(base64: "SGVsbG8=")
    /// print(String(data: data!, encoding: .utf8)!) // "Hello"
    /// ```
    init?(base64: String) {
        if let data = Data(base64Encoded: base64) {
            self = data
        } else {
            return nil
        }
    }
    
    /// Data를 Gzip 압축합니다.
    /// - Returns: Gzip 압축된 Data
    /// - Example:
    /// ```swift
    /// let data = "Hello, Swift!".data(using: .utf8)!
    /// let compressed = data.gzipCompress
    /// ```
    var gzipCompress: Data? {
        return compress(using: COMPRESSION_ZLIB)
    }
    
    /// Gzip 압축을 해제합니다.
    /// - Returns: 압축 해제된 Data
    /// - Example:
    /// ```swift
    /// if let decompressed = compressed?.gzipDecompress {
    ///     print(String(data: decompressed, encoding: .utf8)!) // "Hello, Swift!"
    /// }
    /// ```
//    var gzipDecompress: Data? {
//        return decompress(using: COMPRESSION_ZLIB)
//    }
    
    /// Data를 JSON 객체로 변환합니다.
    /// - Returns: 변환된 JSON 객체
    /// - Example:
    /// ```swift
    /// let jsonData = "{\"key\": \"value\"}".data(using: .utf8)!
    /// let jsonObject = jsonData.toJSONObject
    /// print(jsonObject) // ["key": "value"]
    /// ```
    var toJSONObject: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: [])
    }
    
    func toUtf8String() -> String? {
        return String(data: self, encoding: .utf8)
    }
    
    /// Data를 UTF-8 문자열로 변환합니다.
    /// - Returns: 변환된 UTF-8 문자열
    /// - Example:
    /// ```swift
    /// let data = "Hello".data(using: .utf8)!
    /// print(data.utf8String!) // "Hello"
    /// ```
    var utf8String: String? {
        return String(data: self, encoding: .utf8)
    }
    
    // 내부 압축 함수
    private func compress(using algorithm: compression_algorithm) -> Data? {
        var destination = Data(count: count)
        let compressedSize = destination.withUnsafeMutableBytes { destPtr in
            self.withUnsafeBytes { srcPtr in
                compression_encode_buffer(destPtr.baseAddress!.assumingMemoryBound(to: UInt8.self),
                                         count,
                                         srcPtr.baseAddress!.assumingMemoryBound(to: UInt8.self),
                                         count,
                                         nil,
                                         algorithm)
            }
        }
        return compressedSize > 0 ? destination.prefix(compressedSize) : nil
    }
    
    /*
    private func decompress(using algorithm: compression_algorithm) -> Data? {
        var destination = Data(count: count * 3)
        let decompressedSize = destination.withUnsafeMutableBytes { destPtr in
            self.withUnsafeBytes { srcPtr in
                compression_decode_buffer(destPtr.baseAddress!.assumingMemoryBound(to: UInt8.self),
                                         destination.count,
                                         srcPtr.baseAddress!.assumingMemoryBound(to: UInt8.self),
                                         count,
                                         nil,
                                         algorithm)
            }
        }
        return decompressedSize > 0 ? destination.prefix(decompressedSize) : nil
    }
     */
}

//
//  FileManager.swift
//  Modex
//
//  Created by seojin on 3/1/25.
//

import Foundation

public extension FileManager {
    
    /// 시스템 임시 디렉토리 URL.
    ///
    /// 임시 디렉토리는 앱 실행 중에만 유효하며, 앱 종료 시 파일들이 삭제될 수 있습니다.
    ///
    /// - Example:
    ///   ```swift
    ///   let tempURL = FileManager.tempDirectory
    ///   print("Temporary Directory: \(tempURL)")
    ///   ```
    static var tempDirectory: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    }
    
    /// 사용자의 Document 디렉토리 URL.
    ///
    /// 이 디렉토리에 저장된 파일은 앱 삭제 시 함께 제거되며, 기본적으로 iCloud 백업 대상이 아닙니다.
    ///
    /// - Example:
    ///   ```swift
    ///   let documentURL = FileManager.documentDirectory
    ///   print("Document Directory: \(documentURL)")
    ///   ```
    static var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    /// iCloud 사용 여부를 확인합니다.
    ///
    /// - Returns: iCloud가 사용 중이면 `true`, 그렇지 않으면 `false`.
    /// - Example:
    ///   ```swift
    ///   if FileManager.hasUbiquityIdentityToken {
    ///       print("iCloud is enabled")
    ///   } else {
    ///       print("iCloud is not enabled")
    ///   }
    ///   ```
    static var hasUbiquityIdentityToken: Bool {
        return FileManager.default.ubiquityIdentityToken != nil
    }
    
    /// Document 디렉토리 내에서 파일 이름과 선택적 확장자를 포함한 파일 URL을 반환합니다.
    ///
    /// - Parameters:
    ///   - filename: 파일 이름.
    ///   - fileExtension: 파일 확장자 (예: "txt"). `nil`이면 확장자 없이 반환합니다.
    /// - Returns: Document 디렉토리 내의 파일 URL.
    /// - Example:
    ///   ```swift
    ///   let fileURL = FileManager.documentURL(filename: "example", fileExtension: "txt")
    ///   print("File URL: \(fileURL)")
    ///   ```
    static func documentURL(filename: String, fileExtension: String? = nil) -> URL {
        let fullFilename: String
        if let ext = fileExtension, !ext.isEmpty {
            fullFilename = "\(filename).\(ext)"
        } else {
            fullFilename = filename
        }
        return documentDirectory.appendingPathComponent(fullFilename)
    }
    
    /// 앱 지원 데이터를 저장하는 Application Support 디렉토리 URL.
    ///
    /// 이 디렉토리는 iCloud 백업 대상이 아니며, 앱 삭제 시에도 유지될 수 있는 데이터 저장에 적합합니다.
    ///
    /// - Returns: Application Support 디렉토리 URL.
    /// - Example:
    ///   ```swift
    ///   let appSupportURL = FileManager.applicationSupportDirectory
    ///   print("Application Support Directory: \(appSupportURL)")
    ///   ```
    static var applicationSupportDirectory: URL {
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Application Support directory not found.")
        }
        return url
    }
    
    /// 앱 라이브러리 데이터를 저장하는 Library 디렉토리 URL.
    ///
    /// Library 디렉토리는 캐시, 설정 등 앱 관련 데이터를 저장하는데 사용됩니다.
    /// 이 디렉토리의 파일에 접근할 때는 적절한 권한 요청 및 확인이 필요할 수 있습니다.
    ///
    /// - Returns: Library 디렉토리 URL.
    /// - Example:
    ///   ```swift
    ///   let libraryURL = FileManager.libraryDirectory
    ///   print("Library Directory: \(libraryURL)")
    ///   ```
    static var libraryDirectory: URL {
        guard let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else {
            fatalError("Library directory not found.")
        }
        return url
    }
    
    
    // MARK: - 추가 유틸리티 함수들
    
    /// 지정한 경로에 디렉토리가 존재하지 않으면 생성합니다.
    ///
    /// - Parameters:
    ///   - url: 생성할 디렉토리의 URL.
    ///   - createIntermediates: 중간 디렉토리도 함께 생성할지 여부 (기본값은 `true`).
    ///   - attributes: 선택적 파일 속성.
    /// - Throws: 디렉토리 생성에 실패하면 오류를 던집니다.
    /// - Example:
    ///   ```swift
    ///   do {
    ///       try FileManager.createDirectoryIfNeeded(at: someDirectoryURL)
    ///       print("Directory created or already exists.")
    ///   } catch {
    ///       print("Failed to create directory: \(error)")
    ///   }
    ///   ```
    static func createDirectoryIfNeeded(at url: URL, withIntermediateDirectories createIntermediates: Bool = true, attributes: [FileAttributeKey: Any]? = nil) throws {
        if !FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: createIntermediates, attributes: attributes)
        }
    }
    
    /// 지정한 URL의 파일 또는 디렉토리가 존재하면 삭제합니다.
    ///
    /// - Parameter url: 삭제할 파일이나 디렉토리의 URL.
    /// - Throws: 삭제에 실패하면 오류를 던집니다.
    /// - Example:
    ///   ```swift
    ///   do {
    ///       try FileManager.removeItemIfExists(at: fileURL)
    ///       print("Item removed successfully.")
    ///   } catch {
    ///       print("Error removing item: \(error)")
    ///   }
    ///   ```
    static func removeItemIfExists(at url: URL) throws {
        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
    }
    
    /// 지정한 파일의 크기를 바이트 단위로 반환합니다.
    ///
    /// - Parameter url: 파일의 URL.
    /// - Returns: 파일 크기 (바이트 단위), 파일이 없거나 오류 발생 시 `nil`을 반환합니다.
    /// - Example:
    ///   ```swift
    ///   if let size = FileManager.fileSize(at: fileURL) {
    ///       print("File size: \(size) bytes")
    ///   } else {
    ///       print("Unable to retrieve file size.")
    ///   }
    ///   ```
    static func fileSize(at url: URL) -> UInt64? {
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: url.path),
              let size = attributes[.size] as? UInt64 else {
            return nil
        }
        return size
    }
    
    /// 지정한 디렉토리의 내용을 URL 배열로 반환합니다.
    ///
    /// - Parameter url: 대상 디렉토리의 URL.
    /// - Returns: 디렉토리 내용물의 URL 배열.
    /// - Throws: 디렉토리 내용을 읽지 못하면 오류를 던집니다.
    /// - Example:
    ///   ```swift
    ///   do {
    ///       let contents = try FileManager.contentsOfDirectory(at: directoryURL)
    ///       contents.forEach { print($0) }
    ///   } catch {
    ///       print("Failed to list directory: \(error)")
    ///   }
    ///   ```
    static func contentsOfDirectory(at url: URL) throws -> [URL] {
        return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
    }
    
    /// 파일을 소스 URL에서 대상 URL로 복사합니다. 대상 파일이 존재하면 덮어쓸지 여부를 선택할 수 있습니다.
    ///
    /// - Parameters:
    ///   - sourceURL: 원본 파일 URL.
    ///   - destinationURL: 복사할 대상 파일 URL.
    ///   - overwrite: 대상 파일이 존재할 경우 덮어쓸지 여부 (기본값은 `false`).
    /// - Throws: 복사에 실패하면 오류를 던집니다.
    /// - Example:
    ///   ```swift
    ///   do {
    ///       try FileManager.copyItem(from: sourceURL, to: destinationURL, overwrite: true)
    ///       print("File copied successfully.")
    ///   } catch {
    ///       print("Copy failed: \(error)")
    ///   }
    ///   ```
    static func copyItem(from sourceURL: URL, to destinationURL: URL, overwrite: Bool = false) throws {
        if overwrite && FileManager.default.fileExists(atPath: destinationURL.path) {
            try removeItemIfExists(at: destinationURL)
        }
        try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
    }
    
    /// 파일을 소스 URL에서 대상 URL로 이동합니다. 대상 파일이 존재하면 덮어쓸지 여부를 선택할 수 있습니다.
    ///
    /// - Parameters:
    ///   - sourceURL: 원본 파일 URL.
    ///   - destinationURL: 이동할 대상 파일 URL.
    ///   - overwrite: 대상 파일이 존재할 경우 덮어쓸지 여부 (기본값은 `false`).
    /// - Throws: 이동에 실패하면 오류를 던집니다.
    /// - Example:
    ///   ```swift
    ///   do {
    ///       try FileManager.moveItem(from: sourceURL, to: destinationURL, overwrite: true)
    ///       print("File moved successfully.")
    ///   } catch {
    ///       print("Move failed: \(error)")
    ///   }
    ///   ```
    static func moveItem(from sourceURL: URL, to destinationURL: URL, overwrite: Bool = false) throws {
        if overwrite && FileManager.default.fileExists(atPath: destinationURL.path) {
            try removeItemIfExists(at: destinationURL)
        }
        try FileManager.default.moveItem(at: sourceURL, to: destinationURL)
    }
    
    /// 지정한 디렉토리 내 모든 파일의 총 크기를 바이트 단위로 계산합니다.
    ///
    /// - Parameter directoryURL: 대상 디렉토리의 URL.
    /// - Returns: 디렉토리 내 파일들의 총 크기 (바이트 단위).
    /// - Throws: 디렉토리 내용을 읽지 못하면 오류를 던집니다.
    /// - Example:
    ///   ```swift
    ///   do {
    ///       let totalSize = try FileManager.directorySize(at: directoryURL)
    ///       print("Directory size: \(totalSize) bytes")
    ///   } catch {
    ///       print("Error calculating directory size: \(error)")
    ///   }
    ///   ```
    static func directorySize(at directoryURL: URL) throws -> UInt64 {
        let contents = try contentsOfDirectory(at: directoryURL)
        return contents.reduce(0) { (size, url) -> UInt64 in
            let fileSize = FileManager.fileSize(at: url) ?? 0
            return size + fileSize
        }
    }
}

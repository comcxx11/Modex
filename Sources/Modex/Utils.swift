import Foundation

public class Utils {

    /// 앱 종료
    public static func killApp(){
        // UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
    }

    #if os(iOS)
    public static var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let build = dictionary["CFBundleVersion"] as? String else {return nil}
        
        let versionAndBuild: String = "ver: \(version), build: \(build)"
        return versionAndBuild
    }
    #endif
    
    public static var ver: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        
        return version
    }
    
    public static var build: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleVersion"] as? String else { return "" }
        
        return version
    }

    public static func generateCurrentTimeStamp(locale: Locale? = nil) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale ?? Locale.current
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: Date())
    }
    
    public static func printFunction(name: String = #function) {
        print("\n[ \(name) ]\n=======================================================\n")
    }
    
    public static func printLine(name: Int = #line) {
        print("\n[ \(name) ]\n=======================================================\n")
    }
    
    public static func printFile(name: String = #file) {
        print("\n[ \(name) ]\n=======================================================\n")
    }
    
    public static func printFilePath(name: String = #filePath) {
        print("\n[ \(name) ]\n=======================================================\n")
    }
    
    public static func printColumn(name: Int = #column) {
        print("\n[ \(name) ]\n=======================================================\n")
    }
}

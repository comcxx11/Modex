import Foundation

class Utils {

    /// 앱 종료
    static func killApp(){
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
    }

    static var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let build = dictionary["CFBundleVersion"] as? String else {return nil}
        
        let versionAndBuild: String = "ver: \(version), build: \(build)"
        return versionAndBuild
    }
    
    static var ver: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        
        return version
    }
    
    static var build: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleVersion"] as? String else { return "" }
        
        return version
    }
}
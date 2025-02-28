import Foundation    // Foundation: 기본적인 데이터 타입과 기능들을 제공합니다.
import Modex         // Modex: JSON 관련 확장 기능들을 제공하는 모듈 (예: toJsonData(), toUtf8String() 등)

/*
 User 클래스는 Encodable 프로토콜을 채택하여 객체를 JSON으로 인코딩할 수 있도록 합니다.
 Encodable을 채택하면, JSONEncoder를 이용해 객체를 JSON Data로 변환할 수 있습니다.
 */
class User: Encodable {

    /*
     초기화 메서드: 객체 생성 시 name과 age를 받아 초기화합니다.
     */
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    // User 객체의 프로퍼티: 이름과 나이를 저장합니다.
    let name: String
    let age: Int
}

/*
 @main 어노테이션은 이 클래스가 프로그램 실행의 진입점임을 나타냅니다.
 */
@main
class Main {
    /*
     main() 정적 메서드는 프로그램이 시작될 때 가장 먼저 호출됩니다.
     여기서는 Encodable_Run 클래스의 start() 메서드를 호출하여 JSON 인코딩 예제를 실행합니다.
     */
    static func main() {
        Encodable_Run().start()
    }
}

/*
 Encodable_Run 클래스는 JSON 인코딩 및 문자열 변환과 관련된 기능들을 실행합니다.
 예제 함수들을 내부에 정의하여 각각 JSON Data, JSON 문자열 등으로 변환하는 작업을 보여줍니다.
 */
class Encodable_Run {

    /*
     start() 메서드는 전체 예제 흐름을 담당합니다.
     내부에 두 개의 함수(toJsonData, toJsonString)를 정의한 후 실행합니다.
     */
    func start() {
        
        // Utils.printFilePath(): 현재 파일의 경로를 출력합니다.
        // (Utils 클래스는 로깅이나 디버깅에 유용한 여러 유틸리티 기능을 제공한다고 가정합니다.)
        Utils.printFilePath()
        
        /*
         toJsonData() 함수는 User 객체를 다양한 JSON 형식으로 변환하는 예제를 보여줍니다.
         내부에서 JSON Data, UTF-8 문자열, Base64 인코딩된 JSON, 일반 JSON 문자열, prettyPrinted JSON 문자열로의 변환을 수행합니다.
         */
        func toJsonData() {
            
            Utils.printFunction()
            
            let user = User(name: "Alice", age: 25)
            
            // user 객체를 JSON Data로 변환합니다.
            // toJsonData() 함수는 Modex 모듈에서 제공하는 확장 메서드일 가능성이 높습니다.
            let jsonData = user.toJsonData()
            
            // 변환된 JSON Data를 UTF-8 인코딩의 문자열로 변환합니다.
            // jsonData가 nil일 수 있으므로 optional chaining을 사용합니다.
            let jsonDataConvertToString = jsonData?.toUtf8String()
            
            // user 객체를 Base64 인코딩된 JSON 문자열로 변환합니다.
            let jsonBase64 = user.toBase64Json()
            
            // user 객체를 일반 JSON 문자열로 변환합니다.
            let jsonString = user.toJsonString()
            
            // user 객체를 가독성이 높은 prettyPrinted JSON 문자열로 변환합니다.
            let jsonStringPretty = user.toJsonString(prettyPrinted: true)
            
            // 변환 결과들을 출력합니다.
            // optional 값인 경우 nil이면 빈 문자열("")을 출력하도록 처리합니다.
            print(jsonData ?? "")
            print(jsonDataConvertToString ?? "")
            print(jsonBase64 ?? "")
            print(jsonString ?? "")
            print(jsonStringPretty ?? "")
        }
        
        /*
         toJsonString() 함수는 User 객체를 JSON 문자열로 변환하는 예제를 보여줍니다.
         기본 JSON 문자열과 prettyPrinted JSON 문자열 두 가지 형태로 변환합니다.
         */
        func toJsonString() {
            
            // Utils.printFunction(): 현재 함수의 이름(여기서는 "toJsonString")을 출력합니다.
            Utils.printFunction()
            
            // 예제로 사용할 User 객체를 생성합니다.
            let user = User(name: "Alice", age: 25)
            
            // user 객체를 일반 JSON 문자열로 변환합니다.
            let jsonString = user.toJsonString()
            
            // user 객체를 prettyPrinted JSON 문자열로 변환합니다.
            let jsonStringPretty = user.toJsonString(prettyPrinted: true)
            
            // 변환된 JSON 문자열들을 출력합니다.
            print(jsonString ?? "")
            print(jsonStringPretty ?? "")
        }
        
        // 정의한 toJsonData() 함수를 호출하여 JSON Data 변환 예제를 실행합니다.
        toJsonData()
        
        // 정의한 toJsonString() 함수를 호출하여 JSON 문자열 변환 예제를 실행합니다.
        toJsonString()
    }
}

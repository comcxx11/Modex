import Foundation
import Modex

@main
class Main {
    static func main() {
        print("Hello, Modex is running!")
        let app = Main()
        app.run()

        print(ModexConfig.a)
    }

    func run() {
        print("Modex is new active!")
    }
}
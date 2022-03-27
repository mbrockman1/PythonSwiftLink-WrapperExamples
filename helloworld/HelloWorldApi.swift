import Foundation

class HelloWorld {
    var true_false: Bool = true
    init() {
        InitHelloWorld_Delegate(delegate: self)
    }
}

extension HelloWorld: HelloWorld_Delegate {

    func send_string(string: String) {
        print(string)
    }

    func true_false_flipper() {
        if true_false {
            true_false = false
        }
        else {
            true_false = true
        }}
    }

}
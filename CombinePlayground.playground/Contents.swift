import Foundation
import Combine

//let myRange = (0...3)
//let cancellable = myRange.publisher
//    .sink(receiveCompletion: { print ("completion: \($0)") },
//          receiveValue: { print ("value: \($0)") })


let integers = (0...3)
integers.publisher
    .sink { print("Received \($0)") }

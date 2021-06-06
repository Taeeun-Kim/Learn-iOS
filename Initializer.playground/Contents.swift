import UIKit

struct User {
    let firstName: String
    let lastName: String
    var age: Int?
    
    // 여기다 init을 쓰면 age를 쓸 수가 없음
    // 여기다 init을 안 쓰면, 무조건 age를 써야 함
//    init(firstName: String, lastName: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//    }
}

extension User {
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

// extension 안에 init을 쓰면, age를 옵셔널처럼 선택이 가능함
let user1 = User(firstName: "", lastName: "")
let user2 = User(firstName: "", lastName: "", age: 10)

let user = User(firstName: "Alex", lastName: "Kim")

// 프로토콜은 정의를 하고 제시를 할 뿐, 스스로 기능을 구현하지는 않는다. 즉, 조건만 정의
protocol CarType {
    init(make: String, model: String, color: String)
}

final class Car: CarType {
    
    // final을 쓰면, required init 대신에 init으로만 사용 가능
    // final을 쓰면, 아무도 Car를 서브클래스로 사용 불가
    // 즉, can not be subclassed, final Version
    // 항상 final을 쓰는걸 추천
    
    required init(make: String, model: String, color: String) {
        self.make = make
        self.model = model
        self.color = color
    }
    
    var make: String
    var model: String
    var color: String
    
//    var vin: String? // init 필요없음
    
    /*
    // designated 데저네이티드
    init(make: String, model: String, color: String) {
        self.make = make
        self.model = model
        self.color = color
    }
    
    // convenience
    convenience init(make: String, model: String) {
        // 밑의 init은 위의 designated init을 부름
        self.init(make: make, model: model, color: "white")
    }
    */
}


/*

// Tesla는 위의 Car를 다 상속 받음
class Tesla: Car {
    // if you add a new property to subclass, then lose all init from parent class
    var range: Double
    
    // tesla 1
    init(make: String, model: String, color: String, range: Double) {
        self.range = range
        // super는 parent class of Tesla -> Car Class
        // designated init을 부름
        super.init(make: make, model: model, color: color)
    }
    
    // tesla 2
//    override init(make: String, model: String, color: String) {
//        self.range = 200
//        super.init(make: make, model: model, color: color)
//    }
    
    // tesla 3
    convenience override init(make: String, model: String, color: String) {
        self.init(make: make, model: model, color: color, range: 200)
    }
}

class CyberTruck: Tesla {
    
    var isTurbo: Bool
    
    convenience override init(make: String, model: String, color: String, range: Double) {
        self.init(make: make, model: model, color: color, range: range, isTurbo: true)
    }
    
    init(make: String, model: String, color: String, range: Double, isTurbo: Bool) {
        self.isTurbo = isTurbo
        super.init(make: make, model: model, color: color, range: range)
    }
}

let car1 = Car(make: "Honda", model: "Accord")

// convenience init -> designated init
let car2 = Car(make: "현대", model: "산타페")
// direct to designated init
let car3 = Car(make: "벤츠", model: "좋은차", color: "blue")

let tesla1 = Tesla(make: "BMW", model: "m4", color: "green", range: 3.0)
tesla1.color = "blue"

let tesla2 = Tesla(make: "", model: "")

*/

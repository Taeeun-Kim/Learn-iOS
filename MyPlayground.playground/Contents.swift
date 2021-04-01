import UIKit

var str = "Hello, I am Taeeun"
var numbers = [1, 2, 3, 4]
var names = ["Taeeun", "Max", "DK"]

for index in 0..<numbers.count{
    print(numbers[index])
}

names.forEach{
    print($0)
}

import Foundation
//
//var components = DateComponents()
//components.hour = 8
//components.minute = 0
//let date = Calendar.current.date(from: components)
//
//let date = Calendar.current.date(from: components) ?? Date.now
//
//let components = Calendar.current.dateComponents([.hour, .minute], from: Date())
//let hour = components.hour ?? 0
//let minute = components.minute ?? 0
//
//print(Date)

//let date = Date().timeIntervalSinceReferenceDate


let past = Date().addingTimeInterval(-50000)

let differentBetweenPastAndNow = -Date().addingTimeInterval(past.timeIntervalSinceNow).timeIntervalSinceNow

let minutes = Int(differentBetweenPastAndNow) / 60 // 초 -> 분

print(minutes)

let hours = minutes / 60 // 분 -> 시간
let hours2 = minutes % 60 // 분 -> 시간

print(hours)
print(hours2)

let days = hours / 24 // 시간 -> 일수

print(days)

print("가주아")

let dateFormatter = DateFormatter()
dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

let dateToString = dateFormatter.string(from: past)
print(dateToString)

let stringToDate = dateFormatter.date(from: dateToString)
print(stringToDate!)

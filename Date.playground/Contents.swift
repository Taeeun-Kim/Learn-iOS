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

let past = Date().addingTimeInterval(-500000)

let differentBetweenPastAndNow = Date().addingTimeInterval(past.timeIntervalSinceNow)

print(past)
print(differentBetweenPastAndNow)

//print(Date().timeIntervalSince(date3))
//
//let ago = Date().timeIntervalSince(date3)


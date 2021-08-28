//
//  ContentView.swift
//  DatePractice
//
//  Created by Taeeun Kim on 28.08.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
//            DataTimer.shared.resetDates()
            DataTimer.shared.check()
        }, label: {
            Text("Button")
        })
    }
}

class DataTimer {

    static var shared = DataTimer()

    var startDate: Date!
    var endDate: Date!
//    var expired: Bool

    private init() {
        check()
//        resetDates()
//        check()
    }

    func check() {
        guard
            let startDate = UserDefaults.standard.object(forKey: "kStartDate") as? Date,
            let endDate = Calendar.current.date(byAdding: .second, value: 5, to: startDate)
        else {
            self.resetDates()
            print("끝남")
            return
        }

        var interval = Date().timeIntervalSince(endDate)
        guard interval < 0 else {
            self.resetUserData()
            self.resetDates()
            return
        }
        print(interval)

        self.startDate = startDate
        self.endDate = endDate

        // log remaining time
        interval = abs(interval)
        let log: [Int] = [86400.0, 3600.0, 60.0].map { value in
            guard interval > value else { return 0 }

            let returnValue = Int(floor(interval / value))
            interval.formTruncatingRemainder(dividingBy: value)
            return returnValue
        }
            
        print("Remaining: \(log[0])d \(log[1])h \(log[2])m \(Int(interval))s")
    }

    private func resetUserData() { }

    private func resetDates() {
        print("???")
        self.startDate = Date()
        self.endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
        UserDefaults.standard.set(startDate, forKey: "kStartDate")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

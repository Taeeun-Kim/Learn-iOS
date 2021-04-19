//
//  FilterFlights.swift
//  Enroute
//
//  Created by CS193p Instructor on 5/12/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI

struct FilterFlights: View {
    @ObservedObject var allAirports = Airports.all
    @ObservedObject var allAirlines = Airlines.all

    @Binding var flightSearch: FlightSearch
    @Binding var isPresented: Bool // @State private var showFilter = false <-를 메인뷰에서 썻으니, 여기에서도 같은 변수를 써야하니 @Binding으로 선언
    
    @State private var draft: FlightSearch
    // 바인딩된 거 말고, 이걸로 변경된거를 전역변수(바인딩)인 self.flightSearch = self.draft에 이렇게 넣어주기, 변경 완료!
    
    init(flightSearch: Binding<FlightSearch>, isPresented: Binding<Bool>) {
        _flightSearch = flightSearch
        _isPresented = isPresented
        _draft = State(wrappedValue: flightSearch.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Destination", selection: $draft.destination) {
                    ForEach(allAirports.codes, id: \.self) { airport in
                        Text("\(self.allAirports[airport]?.friendlyName ?? airport)").tag(airport)
                    }
                }
                Picker("Origin", selection: $draft.origin) {
                    Text("Any").tag(String?.none)
                    ForEach(allAirports.codes, id: \.self) { (airport: String?) in
                        Text("\(self.allAirports[airport]?.friendlyName ?? airport ?? "Any")").tag(airport)
                    }
                }
                Picker("Airline", selection: $draft.airline) {
                    Text("Any").tag(String?.none)
                    ForEach(allAirlines.codes, id: \.self) { (airline: String?) in
                        Text("\(self.allAirlines[airline]?.friendlyName ?? airline ?? "Any")").tag(airline)
                    }
                }
                Toggle(isOn: $draft.inTheAir) { Text("Enroute Only") }
            }
            .navigationBarTitle("Filter Flights")
                .navigationBarItems(leading: cancel, trailing: done)
        }
    }
    
    var cancel: some View {
        Button("Cancel") {
            self.isPresented = false
            // Cancel 누르면 변경된 거는, 바인딩된 전역변수가 아닌 draft에 저장했고, 그 변경점을 전역변수에 안 넣어줬으니, 변경한게 무효로 됨, 즉 cancel!
        }
    }
    var done: some View {
        Button("Done") {
            self.flightSearch = self.draft
            self.isPresented = false
        }
    }
}

//struct FilterFlights_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterFlights()
//    }
//}

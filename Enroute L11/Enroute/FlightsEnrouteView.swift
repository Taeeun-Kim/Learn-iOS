//
//  FlightsEnrouteView.swift
//  Enroute
//
//  Created by CS193p Instructor.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI

// 여기에 해당하는 조건들만 검색
struct FlightSearch {
    var destination: String
    var origin: String?
    var airline: String?
    var inTheAir: Bool = true
}

struct FlightsEnrouteView: View {
    @State var flightSearch: FlightSearch
    
    var body: some View {
        NavigationView {
            FlightList(flightSearch)
                .navigationBarItems(leading: simulation, trailing: filter)
        }
    }
    
    @State private var showFilter = false
    
    var filter: some View {
        Button("Filter") {
            self.showFilter = true // Bool 함수 true/false 바로 넣어주기 네이밍은 show+Filter 이런식으로, 그리고 바로위에 변수 선언 해주기 -> @State private var showFilter = false 기본 false로
        }
        .sheet(isPresented: $showFilter) {
            // .sheet에는 isPresented: 에 Bool 변수 넣어주기 달러사인 필수
            // 왜 $이냐면, 버튼을 누르고 true에서 sheet 화면에서 dismiss를 누르면 다시 false로 변해야하기 때문에
            // 즉 읽기 쓰기 권한을 주기 위해
            FilterFlights(flightSearch: self.$flightSearch, isPresented: self.$showFilter)
        }
    }
    
    // if no FlightAware credentials exist in Info.plist
    // then we simulate data from KSFO and KLAS (Las Vegas, NV)
    // the simulation time must match the times in the simulation data
    // so, to orient the UI, this simulation View shows the time we are simulating
    var simulation: some View {
        let isSimulating = Date.currentFlightTime.timeIntervalSince(Date()) < -1
        return Text(isSimulating ? DateFormatter.shortTime.string(from: Date.currentFlightTime) : "")
    }
}

struct FlightList: View {
    // View Model
    @ObservedObject var flightFetcher: FlightFetcher

    init(_ flightSearch: FlightSearch) {
        self.flightFetcher = FlightFetcher(flightSearch: flightSearch)
    }

    var flights: [FAFlight] { flightFetcher.latest }
    
    var body: some View {
        List {
            ForEach(flights, id: \.ident) { flight in
                FlightListEntry(flight: flight)
            }
        }
        .navigationBarTitle(title)
    }
    
    private var title: String {
        let title = "Flights"
        if let destination = flights.first?.destination {
            return title + " to \(destination)"
        } else {
            return title
        }
    }
}

struct FlightListEntry: View {
    @ObservedObject var allAirports = Airports.all
    @ObservedObject var allAirlines = Airlines.all
    
    var flight: FAFlight

    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
            Text(arrives).font(.caption)
            Text(origin).font(.caption)
        }
            .lineLimit(1)
    }
    
    var name: String {
        return "\(allAirlines[flight.airlineCode]?.friendlyName ?? "Unknown Airline") \(flight.number)"
    }

    var arrives: String {
        let time = DateFormatter.stringRelativeToToday(Date.currentFlightTime, from: flight.arrival)
        if flight.departure == nil {
            return "scheduled to arrive \(time) (not departed)"
        } else if flight.arrival < Date.currentFlightTime {
            return "arrived \(time)"
        } else {
            return "arrives \(time)"
        }
    }

    var origin: String {
        return "from " + (allAirports[flight.origin]?.friendlyName ?? "Unknown Airport")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlightsEnrouteView(flightSearch: FlightSearch(destination: "KSFO"))
    }
}

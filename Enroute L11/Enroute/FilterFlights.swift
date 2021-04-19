//
//  FilterFlights.swift
//  Enroute
//
//  Created by CS193p Instructor on 5/12/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI

struct FilterFlights: View {
    @ObservedObject var allAirports = Airports.all // View Model, 복붙 from 메인뷰(FlightListEntry)
    @ObservedObject var allAirlines = Airlines.all

    // 아직 var flightSearch와 var isPresented들은 initialize가 안됨 -> init으로 초기화 ㄱ
    // 밑에 두개는 아직 논 언더바 버전 = wrapped value of this struct
    // 달러가 붙으면 projected value of this struct
    // init 되기전에는 사용 불가
    @Binding var flightSearch: FlightSearch // FlightSearch는 struct지만 var로 변수로 받아버림
    @Binding var isPresented: Bool // @State private var showFilter = false <-를 메인뷰에서 썻으니, 여기에서도 같은 변수를 써야하니 @Binding으로 선언
    
    @State private var draft: FlightSearch
    // 바인딩된 거 말고, 이걸로 변경된거를 전역변수(바인딩)인 self.flightSearch = self.draft에 이렇게 넣어주기, 변경 완료!
    
    // Binding은 제네릭, don't care about type, _도 같은 의미, 그러니깐 바인딩은 언더스코어로 선언!!!
    init(flightSearch: Binding<FlightSearch>, isPresented: Binding<Bool>) { // 아하, Binding 된 거를 이렇게 init 시켜줌!
        _flightSearch = flightSearch
        _isPresented = isPresented
        _draft = State(wrappedValue: flightSearch.wrappedValue)
//        self.draft = flightSearch self.draft는 FlightSearch가 밸류이고, flightSearch의 밸류는 Binding<FlightSearch>라서 안됨
//        Cannot assign value of type 'Binding<FlightSearch>' to type 'FlightSearch'
    }
    
    /*
    언더스코어 예제:
    func myFunc(label name: Int) // call it like myFunc(label: 3)
    func myFunc(name: Int) // call it like myFunc(name: 3)
    func myFunc(_ name: Int) // call it like myFunc(3)
    */
    
    var body: some View {
        NavigationView { // Form에는 네비게이션뷰가 필수!!!!!!!
            Form {
                /*
                 대부분 String, selection, content 적혀있는 Picker만 사용함
                 selection: what I want to change -> $draft.destination
                 Picker의 content는 대부분 ForEach 사용
                 tag()는 리스트 여러개 중에서 고르면, 그 고른 것을 그대로 selection: 에 넣어버림
                 !!그러므로!! selection:의 변수와, tag() 안의 변수는 같은 type이어야 함!!! (as this binding is bound to, 33:57초)
                 State: Bool value
                 $State: Binding<Bool> value
                 
                 밑의 예시를 보면 $draft.destination에서 destination은 var destination: String로 스트링
                 allAirports.codes도 var codes: [String]으로 같은 스트링임, 그러므로 No Error
                */
                Picker("Destination", selection: $draft.destination) {
                    ForEach(allAirports.codes, id: \.self) { airport in
                        Text("\(self.allAirports[airport]?.friendlyName ?? airport)").tag(airport)
                    }
                }
                Picker("Origin", selection: $draft.origin) {
                    Text("Any").tag(String?.none) // 그냥 .tag(nil) 쓸 수 없는 이유는, 이게 String nil인지 확실하지 않아서임
                    
                    // var origin: String? 오리진은 optional value임 그러므로 tag에도 옵셔널이 들어가야함, 고로 (airport: String?) 이렇게 선언해주기
                    ForEach(allAirports.codes, id: \.self) { (airport: String?) in
                        Text("\(self.allAirports[airport]?.friendlyName ?? airport ?? "Any")").tag(airport)
                        // ?? 써주는게 unwrapped 해주는거임
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

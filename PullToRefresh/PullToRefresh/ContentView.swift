//
//  ContentView.swift
//  PullToRefresh
//
//  Created by Taeeun Kim on 07.06.21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var customerListVM = CustomerListViewModel()
    
    var body: some View {
        List(customerListVM.customers, id: \.self) { customer in
            Text(customer)
        }
        .onAppear {
            customerListVM.fetch()
        }
        // iOS 15, XCode 13
        .refreshable {
            customerListVM.fetch()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  CustomerListViewModel.swift
//  PullToRefresh
//
//  Created by Taeeun Kim on 07.06.21.
//

import Foundation

class CustomerListViewModel: ObservableObject {
    
    @Published var customers: [String] = []
    
    func fetch() {
        
        let letters = "abcdefghijklmnopqrstuvwxyz"
        var names: [String] = []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            for _ in 1...20 {
                let randomName = String((0...letters.count).map{ _ in letters.randomElement()! })
                names.append(randomName)
            }
            
            self.customers = names
        }
    }
}

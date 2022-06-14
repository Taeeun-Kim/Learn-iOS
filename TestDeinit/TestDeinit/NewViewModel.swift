//
//  NewViewModel.swift
//  TestDeinit
//
//  Created by Taeeun Kim on 03.05.22.
//

import Foundation

class NewViewModel: ObservableObject {
    
    var name = "name"
    
    init() {
        name = "new name"
        print("init")
    }
    
    deinit {
        print("deinit")
    }
}

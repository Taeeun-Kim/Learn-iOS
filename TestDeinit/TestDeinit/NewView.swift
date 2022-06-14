//
//  NewView.swift
//  TestDeinit
//
//  Created by Taeeun Kim on 03.05.22.
//

import SwiftUI

struct NewView: View {
    
    @StateObject var viewModel: NewViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.name)
        }
    }
}

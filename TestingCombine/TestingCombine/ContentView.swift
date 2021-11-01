//
//  ContentView.swift
//  TestingCombine
//
//  Created by Taeeun Kim on 31.10.21.
//

import SwiftUI

// Models
struct User: Decodable

// ViewModels
import Combine

final class ViewModel: ObservableObject {
    
    @Published var time = ""
    private var anyCancellable: AnyCancellable?
    
    let formatter: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .medium
        return df
    }()
    
    
    init() {
        setupPublishers()
    }
    
    private func setupPublishers() {
        setupTimerPublisher()
    }
    
    private func setupDataTaskPublisher() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
    }
    
    private func setupTimerPublisher() {
        anyCancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { value in
                self.time = self.formatter.string(from: value)
            }
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        Text(viewModel.time)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  TestingCombine
//
//  Created by Taeeun Kim on 31.10.21.
//

import SwiftUI

// Models
struct User: Decodable, Identifiable {
    let id: Int
    let name: String
}

// ViewModels
import Combine

final class ViewModel: ObservableObject {
    
    @Published var time = ""
    @Published var users = [User]()
    
    private var cancellables = Set<AnyCancellable>()
    
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
        setupDataTaskPublisher()
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
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { users in
                self.users = users
            }
            .store(in: &cancellables)

    }
    
    private func setupTimerPublisher() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { value in
                self.time = self.formatter.string(from: value)
            }
            .store(in: &cancellables)
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.time)
                .padding()
            List(viewModel.users) { user in
                Text(user.name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

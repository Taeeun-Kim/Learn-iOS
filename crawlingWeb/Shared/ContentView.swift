//
//  ContentView.swift
//  Shared
//
//  Created by Taeeun Kim on 07.03.22.
//

import Combine
import SwiftUI
import SwiftSoup

struct ContentView: View {
    
    @StateObject var vm = IndeedViewModel()
    
    var body: some View {
        VStack {
            Text("go: \(vm.jobCount)")
        }
        .onAppear {
            vm.start()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class IndeedViewModel: ObservableObject {

    private var cancellable: AnyCancellable?

    @Published var jobCount: String = ""
    var data: Data?
    let baseURL = "https://de.indeed.com/jobs?q=chemie"
    
    func start() {
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: baseURL)!)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    self.data = $0.data

                    let html = String(data: self.data!, encoding: .utf8) ?? ""
                    let doc: Document = try! SwiftSoup.parseBodyFragment(html)
                    let searchCountPages = try! doc.getElementById("searchCountPages")

                    self.jobCount = try! searchCountPages?.text() ?? ""
                })
    }
}

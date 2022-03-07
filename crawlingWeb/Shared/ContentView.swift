//
//  ContentView.swift
//  Shared
//
//  Created by Taeeun Kim on 07.03.22.
//

import SwiftUI
import SwiftSoup

struct ContentView: View {
    
    @StateObject var vm = IndeedViewModel()
    
    var body: some View {
        VStack {
            TextField("Type here: ", text: $vm.search)
                .padding()
            
            Button {
                vm.start()
            } label: {
                Text("Enter")
                    .font(.headline)
            }

            Text("\(vm.jobCount)")
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
    
    @Published var jobCount: String = ""
    @Published var search: String = "chemie"
    
    let baseURL = "https://de.indeed.com/jobs?q="
    
    func start() {
        let editedURL = baseURL + search
        let task = URLSession.shared.dataTask(with: URL(string: editedURL)!) { data, response, error in
            guard
                let data = data,
                error == nil,
                let document = String(data: data, encoding: .utf8) else { return }
            do {
                let html: String = document
                let doc: Document = try SwiftSoup.parseBodyFragment(html)
                let searchCountPages = try doc.getElementById("searchCountPages")

                self.jobCount = try searchCountPages?.text() ?? ""
            } catch {
                print("error")
            }
        }
        task.resume()
    }
}

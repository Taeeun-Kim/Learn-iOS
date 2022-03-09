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
            ForEach(vm.jobCount, id: \.self) { go in
                Text(go)
            }
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
    let links = ["https://de.indeed.com/jobs?q=swift", "https://de.indeed.com/jobs?q=react", "https://de.indeed.com/jobs?q=flutter"]
    
    @Published var jobCount: [String] = []
    
    func start() {
        
        TaskManager.shared.dataTask(with: URL(string: links[0])!) { (data, response, error) in
            let html = String(data: data ?? Data(), encoding: .utf8) ?? ""
            let doc: Document = try! SwiftSoup.parseBodyFragment(html)
            let searchCountPages = try! doc.getElementById("searchCountPages")

            let str = try! searchCountPages?.text() ?? ""
            let start = str.index(str.startIndex, offsetBy: 12)
            let end = str.index(str.endIndex, offsetBy: -5)
            let range = start..<end
            let test = String(str[range])

            self.jobCount.append(test)
        }
        
        TaskManager.shared.dataTask(with: URL(string: links[1])!) { (data, response, error) in
            let html = String(data: data ?? Data(), encoding: .utf8) ?? ""
            let doc: Document = try! SwiftSoup.parseBodyFragment(html)
            let searchCountPages = try! doc.getElementById("searchCountPages")

            let str = try! searchCountPages?.text() ?? ""
            let start = str.index(str.startIndex, offsetBy: 12)
            let end = str.index(str.endIndex, offsetBy: -5)
            let range = start..<end
            let test = String(str[range])

            self.jobCount.append(test)
        }
        
        TaskManager.shared.dataTask(with: URL(string: links[2])!) { (data, response, error) in
            let html = String(data: data ?? Data(), encoding: .utf8) ?? ""
            let doc: Document = try! SwiftSoup.parseBodyFragment(html)
            let searchCountPages = try! doc.getElementById("searchCountPages")

            let str = try! searchCountPages?.text() ?? ""
            let start = str.index(str.startIndex, offsetBy: 12)
            let end = str.index(str.endIndex, offsetBy: -5)
            let range = start..<end
            let test = String(str[range])

            self.jobCount.append(test)
        }
        
//        let pub1 = URLSession.shared.dataTaskPublisher(for: URL(string: links[0])!)
//            .map { $0.data }
//        let pub2 = URLSession.shared.dataTaskPublisher(for: URL(string: links[1])!)
//            .map { $0.data }
//
//        cancellable = Publishers.Zip(pub1, pub2)
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    fatalError(error.localizedDescription)
//                }
//            }, receiveValue: { go in
//                let html = String(data: go.0, encoding: .utf8) ?? ""
//                let doc: Document = try! SwiftSoup.parseBodyFragment(html)
//                let searchCountPages = try! doc.getElementById("searchCountPages")
//
//                let str = try! searchCountPages?.text() ?? ""
//                let start = str.index(str.startIndex, offsetBy: 12)
//                let end = str.index(str.endIndex, offsetBy: -5)
//                let range = start..<end
//                let test = String(str[range])
//
//                self.jobCount.append(test)
//
//                let html2 = String(data: go.1, encoding: .utf8) ?? ""
//                let doc2: Document = try! SwiftSoup.parseBodyFragment(html2)
//                let searchCountPages2 = try! doc2.getElementById("searchCountPages")
//
//                let str2 = try! searchCountPages2?.text() ?? ""
//                let start2 = str2.index(str2.startIndex, offsetBy: 12)
//                let end2 = str2.index(str2.endIndex, offsetBy: -5)
//                let range2 = start2..<end2
//                let test2 = String(str2[range2])
//
//                self.jobCount.append(test2)
//            })
    }
}

class TaskManager {
    static let shared = TaskManager()
    
    let session = URLSession(configuration: .default)
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var tasks = [URL: [completionHandler]]()
    
    func dataTask(with url: URL, completion: @escaping completionHandler) {
        if tasks.keys.contains(url) {
            tasks[url]?.append(completion)
        } else {
            tasks[url] = [completion]
            let _ = session.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    
                    print("Finished network task")
                    
                    guard let completionHandlers = self?.tasks[url] else { return }
                    for handler in completionHandlers {
                        
                        print("Executing completion block")
                        
                        handler(data, response, error)
                    }
                }
            }).resume()
        }
    }
}

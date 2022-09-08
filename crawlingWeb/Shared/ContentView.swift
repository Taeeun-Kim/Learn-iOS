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
            Text("")
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
    let links = [
        URL(string: "http://localhost:8080")!
    ]
    
    @Published var jobCount: [String] = []
    @Published var test: String = ""
    @Published var test2: [String] = []
    
    
    func start() {
        
        for link in links {
            TaskManager.shared.dataTask(with: link) { (data, response, error) in
                let html = String(data: data ?? Data(), encoding: .utf8) ?? ""
                let doc: Document = try! SwiftSoup.parseBodyFragment(html)
                let issues = try! doc.getElementsByClass("jira-issue conf-macro output-block")
                
                for issue in issues {
                    let issueInText = try! issue.text()
                    var str = ""
                    var count = 0
                    
                    for char in issueInText {
                        if char != " ", count == 0 {
                            str.append(char)
                        } else {
                            count += 1
                        }
                    }
                    str = " AND NOT issuekey = \"" + str + "\""
                    print(str)
                    self.test2.append(str)
//                     AND NOT issuekey = "IMOWAPP-4229"
                }
            }
            test2.
        }
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

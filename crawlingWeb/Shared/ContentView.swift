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
    
    let people = ["Taeeun", "Jessica", "Estelle"]
    let photos = ["flower", "flower", "Tisch", "Toy"]

    var body: some View {
        VStack {
            ForEach(photos, id: \.self) { photo in
                Text(photo)
            }
            
            Button {
                photos.map { print($0) }
//                photos.map { photo in
//                    print(photo)
//                }
            } label: {
                Text("Click")
            }
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
        URL(string: "https://de.indeed.com/jobs?q=swift")!,
        URL(string: "https://de.indeed.com/jobs?q=kotlin")!,
        URL(string: "https://de.indeed.com/jobs?q=react")!,
        URL(string: "https://de.indeed.com/jobs?q=flutter")!,
        URL(string: "https://de.indeed.com/jobs?q=python")!,
        URL(string: "https://de.indeed.com/jobs?q=java")!,
        URL(string: "https://de.indeed.com/jobs?q=javascript")!,
        URL(string: "https://de.indeed.com/jobs?q=ios")!,
        URL(string: "https://de.indeed.com/jobs?q=android")!,
    ]
    
    @Published var jobCount: [String] = []
    
    func start() {
        
        for link in links {
            TaskManager.shared.dataTask(with: link) { (data, response, error) in
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

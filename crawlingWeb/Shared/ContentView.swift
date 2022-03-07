//
//  ContentView.swift
//  Shared
//
//  Created by Taeeun Kim on 07.03.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = IndeedViewModel()
    
    var body: some View {
        VStack {
            Text("gazua")
        }
        .onAppear {
            vm.crawl()
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
    
    let wordToSearch = "Seite 1 von "
    let maximumPagesToVisit = 10
    
    let semaphore = DispatchSemaphore(value: 0)
    var visitedPages: Set<URL> = []
    var pagesToVisit: Set<URL> = [URL(string: "https://de.indeed.com/jobs?q=ios")!]
    
    func crawl() {
        guard visitedPages.count <= maximumPagesToVisit else {
            print("🏁 Reached max number of pages to visit")
            semaphore.signal()
            return
        }
        guard let pageToVisit = pagesToVisit.popFirst() else {
            print("🏁 No more pages to visit")
            semaphore.signal()
            return
        }
        if visitedPages.contains(pageToVisit) {
            crawl()
        } else {
            visit(page: pageToVisit)
        }
    }
    
    func visit(page url: URL) {
        visitedPages.insert(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.crawl() }
            guard
                let data = data,
                error == nil,
                let document = String(data: data, encoding: .utf8) else { return }
            self.parse(document: document, url: url)
        }
        
        print("🔎 Visiting page: \(url)")
        task.resume()
    }
    
    func parse(document: String, url: URL) {
        func find(word: String) {
            if document.contains(word) {
                print("✅ Word '\(word)' found at page \(url)")
            }
        }
        find(word: wordToSearch)
    }
    
    //    crawl()
    //    semaphore.wait()
}

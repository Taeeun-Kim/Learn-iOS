//
//  ContentView.swift
//  test
//
//  Created by Taeeun Kim on 13.09.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("fw")
        }
//        Text("Hello, world!")
        
        //            .padding()
    }
    
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

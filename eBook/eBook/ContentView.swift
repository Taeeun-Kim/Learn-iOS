//
//  ContentView.swift
//  eBook
//
//  Created by Kavsoft on 16/03/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit
import AVFoundation

//struct ContentView: View {
//    var body: some View {
//
//        NavigationView{
//
//            Home()
//            .navigationBarTitle("Books")
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//struct Home : View {
//
//    @ObservedObject var Books = getData()
//    @State var show = false
//    @State var url = ""
//
//    var body : some View{
//
//        List(Books.data){i in
//
//            HStack{
//
//                if i.imurl != ""{
//
//                  WebImage(url: URL(string: i.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10)
//                }
//                else{
//
//                    Image("books").resizable().frame(width: 120, height: 170).cornerRadius(10)
//                }
//
//
//                VStack(alignment: .leading, spacing: 10) {
//
//                    Text(i.title).fontWeight(.bold)
//
//                    Text(i.authors)
//
//                    Text(i.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading)
//                }
//            }
//            .onTapGesture {
//
//                self.url = i.url
//                self.show.toggle()
//            }
//
//        }.sheet(isPresented: self.$show) {
//
//            WebView(url: self.url)
//        }
//    }
//}
//
//class getData : ObservableObject{
//
//    @Published var data = [Book]()
//
//    init() {
//
//        // any search query....
//        //spaces must be replaced by +...
//
//        let url = "https://www.googleapis.com/books/v1/volumes?q=fiction&langRestrict=ko"
//
//        let session = URLSession(configuration: .default)
//
//        session.dataTask(with: URL(string: url)!) { (data, _, err) in
//
//            if err != nil{
//
//                print((err?.localizedDescription)!)
//                return
//            }
//
//            let json = try! JSON(data: data!)
//
//            let items = json["items"].array!
//
//            for i in items{
//
//                let id = i["id"].stringValue
//
//                let title = i["volumeInfo"]["title"].stringValue
//
//                let authors = i["volumeInfo"]["authors"].array!
//
//                var author = ""
//
//                for j in authors{
//
//                    author += "\(j.stringValue)"
//                }
//
//                let description = i["volumeInfo"]["description"].stringValue
//
//                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
//
//                let url1 = i["volumeInfo"]["previewLink"].stringValue
//
//                DispatchQueue.main.async {
//
//                    self.data.append(Book(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1))
//                }
//            }
//
//        }.resume()
//    }
//}
//
//struct Book : Identifiable {
//
//    var id : String
//    var title : String
//    var authors : String
//    var desc : String
//    var imurl : String
//    var url : String
//}
//
//
//struct WebView : UIViewRepresentable {
//
//    var url : String
//
//    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
//
//        let view = WKWebView()
//        view.load(URLRequest(url: URL(string: url)!))
//        return view
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
//
//
//    }
//}


struct Book: Codable {
    let title: String
    let authors: [String]
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
}

struct Volume: Codable {
    let volumeInfo: VolumeInfo
}

struct Response: Codable {
    let items: [Volume]
}

class BooksViewModel: ObservableObject {
    @Published var books: [Book] = []
    
  func searchBooks(query: String, withISBN: Bool) {
    guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
      return
    }
    
    var url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(encodedQuery)&langRestrict=ko")!
    
    if withISBN {
      url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=isbn:\(query)&langRestrict=ko")!
    }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else {
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Response.self, from: data)
        DispatchQueue.main.async {
          self.books = response.items.map { item in
            Book(title: item.volumeInfo.title, authors: item.volumeInfo.authors ?? [])
          }
        }
      } catch {
        print(error)
      }
    }
    
    task.resume()
  }
}

struct ContentView: View {
  @StateObject var viewModel = BooksViewModel()
  @State var query: String = ""
  
  var body: some View {
    VStack {
      TextField("Search for books", text: $query, onCommit: {
        viewModel.searchBooks(query: query, withISBN: false)
      })
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .padding()
      
      Button("search with isbn") {
        viewModel.searchBooks(query: query, withISBN: true)
      }
      
      VStack {
        CameraView(barcodeData: $query)
          .frame(maxWidth: .infinity, maxHeight: 300)
        
        Text("Barcode data: \(query)")
          .padding()
        
        Spacer()
      }
      
      List(viewModel.books, id: \.title) { book in
        VStack(alignment: .leading) {
          Text(book.title)
            .font(.headline)
          
          Text(book.authors.joined(separator: ", "))
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct Camera: View {
    @State private var barcodeData = ""

    var body: some View {
        VStack {
            CameraView(barcodeData: $barcodeData)
                .frame(maxWidth: .infinity, maxHeight: 300)
            
            Text("Barcode data: \(barcodeData)")
                .padding()
            
            Spacer()
        }
    }
}

struct CameraView: UIViewRepresentable {
    @Binding var barcodeData: String
    
  func makeUIView(context: Context) -> UIView {
      let captureSession = AVCaptureSession()
      guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return UIView() }
      let videoInput: AVCaptureDeviceInput
      do {
          videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
      } catch {
          return UIView()
      }
      
      if (captureSession.canAddInput(videoInput)) {
          captureSession.addInput(videoInput)
      } else {
          return UIView()
      }
      
      let metadataOutput = AVCaptureMetadataOutput()
      
      if (captureSession.canAddOutput(metadataOutput)) {
          captureSession.addOutput(metadataOutput)
          
          metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
          metadataOutput.metadataObjectTypes = [.ean13, .ean8, .pdf417]
      } else {
          return UIView()
      }
      
      let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      previewLayer.videoGravity = .resizeAspectFill
      
      let cameraView = UIView(frame: CGRect.zero)
      cameraView.layer.addSublayer(previewLayer)
    
    DispatchQueue.main.async {
      previewLayer.frame = cameraView.bounds
    }

      
      DispatchQueue.global().async {
          captureSession.startRunning()
      }
    
      
      return cameraView
  }


    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Do nothing
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            guard let metadataObject = metadataObjects.first else {
                return
            }
            
            if let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
               let code = readableObject.stringValue {
                parent.barcodeData = code
            }
        }
    }
}

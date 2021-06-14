//
//  URLImage.swift
//  URLImageDemo
//
//  Created by Taeeun Kim on 14.06.21.
//

import SwiftUI

struct URLImage: View {
    
    @ObservedObject var imageLoader = ImageLoader()
    
    let url: String
    let placeholder: String
    
    init(url: String, placeholder: String = "placeholder") {
        self.url = url
        self.placeholder = placeholder
        self.imageLoader.downloadImage(url: self.url)
    }
    
    var body: some View {
        
        if let data = self.imageLoader.downloadedData {
            return Image(uiImage: UIImage(data: data)!).resizable()
        } else {
            return Image("placeholder").resizable()
        }
        
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "https://upload.wikimedia.org/wikipedia/en/d/d0/Dogecoin_Logo.png")
    }
}

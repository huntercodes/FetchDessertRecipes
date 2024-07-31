//
//  AsyncImage.swift
//  FetchDessertRecipes
//
//  Created by hunter downey on 7/30/24.
//

import SwiftUI

// AsyncImage with ImageLoader for the large list to load thumbnails better using cached images
struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    var placeholder: Image
    
    init(url: URL, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }
    
    var body: some View {
        content
            .onAppear {
                loader.load()
            }
    }
    
    private var content: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .transition(.opacity)
            } else {
                placeholder
                    .resizable()
                    .transition(.opacity)
            }
        }
    }
}

// ImageLoader used with AsyncImage to allow for cached images
class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    private let url: URL
    
    private let cache = ImageCache.shared
    
    init(url: URL) {
        self.url = url
    }
    
    func load() {
        if let cachedImage = cache.getImage(forKey: url.absoluteString) {
            image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let loadedImage = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.cache.setImage(loadedImage, forKey: self.url.absoluteString)
                self.image = loadedImage
            }
        }.resume()
    }
    
}

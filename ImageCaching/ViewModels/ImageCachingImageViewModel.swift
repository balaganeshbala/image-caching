//
//  ImageCachingImageViewModel.swift
//  ImageCaching
//
//  Created by Balaganesh on 09/05/23.
//

import SwiftUI
import Combine

class ImageCachingImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    let imageUrl: String
    let id: String
    
    init(url: String, id: String) {
        self.imageUrl = url
        self.id = id
        if let image = ImageCachingCacheService.instance.getImageFromCache(key: id) {
            print("Using image from cache!")
            self.image = image
        } else {
            print("Downloading image!")
            downloadImage()
        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data: Data, response: URLResponse) in
                UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { image in
                if let image = image {
                    ImageCachingCacheService.instance.cacheImage(key: self.id, image: image)
                }
                self.image = image
                self.isLoading = false
            }
            .store(in: &cancellables)

    }
}

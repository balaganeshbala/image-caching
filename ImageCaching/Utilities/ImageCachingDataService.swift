//
//  ImageCachingDataService.swift
//  ImageCaching
//
//  Created by Balaganesh on 10/05/23.
//

import Foundation
import Combine

class ImageCachingDataService {
    
    @Published var photosData: [PhotoModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    static let instance = ImageCachingDataService()
    
    private init() {
        self.downloadPhotosData()
    }
    
    func downloadPhotosData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    
                    break;
                case .failure(let err):
                    print("Error in fetching photos data: \(err)")
                    break;
                }
            }, receiveValue: { [weak self] photos in
                self?.photosData = photos
            })
            .store(in: &cancellables)
    }
    
}

//
//  ImageCachingViewModel.swift
//  ImageCaching
//
//  Created by Balaganesh on 09/05/23.
//

import Foundation
import Combine

class ImageCachingViewModel: ObservableObject {
    
    @Published var photos: [PhotoModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        ImageCachingDataService.instance.$photosData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] photosData in
                self?.photos =  photosData
            }
            .store(in: &cancellables)

    }
    
}

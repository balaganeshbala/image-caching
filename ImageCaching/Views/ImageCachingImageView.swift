//
//  ImageCachingImageView.swift
//  ImageCaching
//
//  Created by Balaganesh on 09/05/23.
//

import SwiftUI

struct ImageCachingImageView: View {
    
    @StateObject var vm: ImageCachingImageViewModel
    
    init(url: String, id: String) {
        _vm = StateObject(wrappedValue: ImageCachingImageViewModel(url: url, id: id))
    }
    
    var body: some View {
        VStack {
            if (vm.isLoading) {
                ProgressView()
            } else if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

struct ImageCachingImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCachingImageView(url: "https://via.placeholder.com/600/92c952", id: "1")
            .previewLayout(.sizeThatFits)
    }
}

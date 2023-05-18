//
//  ImageCachingRowView.swift
//  ImageCaching
//
//  Created by Balaganesh on 09/05/23.
//

import SwiftUI

struct ImageCachingRowView: View {
    
    let photo: PhotoModel
    
    var body: some View {
        HStack {
            ImageCachingImageView(url: photo.url, id: "\(photo.id)")
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading) {
                Text(photo.title)
                Text(photo.url)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 5.0)
        }
    }
}

struct ImageCachingRowView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCachingRowView(photo: PhotoModel(albumId: 1, id: 1, title: "Some title", url: "Some Url", thumbnailUrl: "Some thumbnailUrl"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

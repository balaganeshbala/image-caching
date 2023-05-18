//
//  ImageCachingView.swift
//  ImageCaching
//
//  Created by Balaganesh on 09/05/23.
//

import SwiftUI

struct ImageCachingView: View {
    
    @StateObject var vm = ImageCachingViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.photos) { photo in
                    ImageCachingRowView(photo: photo)
                }
            }.listStyle(.plain)
            .navigationTitle("ImageCaching")
        }
    }
}

struct ImageCachingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCachingView()
    }
}

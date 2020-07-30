//
//  ModalView.swift
//  APOD
//
//  Created by Derek Chan on 2020/7/30.
//

import SwiftUI

struct ModalView: View {
    @Binding var block: ApodBlockData
    
    var apod: ApodResult {
        block.content
    }
    
    @Binding var loadedImage: UIImage?
    
    var body: some View {
        VStack {
            VStack {
                if apod.mediaType == .Image {
                    AsyncImage(url: apod.hdurl!, image: $loadedImage)
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(block: .constant(.init(content: singleApod)), loadedImage: .constant(nil))
    }
}

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
                } else {
                    WebView(request: .init(url: apod.url!))
                }
            }
            .clipped()
            .padding()
            
            List{
                VStack(alignment: .leading, spacing: 4){
                    Text(apod.title)
                        .font(.largeTitle)
                        .bold()
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Button(action: {
                        block.favourite.toggle()
                    }){
                        Image(systemName: self.block.favourite ? "star.fill" : "star")
                            .imageScale(.large)
                            .foregroundColor(self.block.favourite ? .yellow : .gray)
                    }
                }
                Text(apod.explanation)
                    .font(.body)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                
//                是否标记版权
                if apod.copyright != nil {
                    Text("© \(apod.copyright!)")
                }
            }
        }
    }
}

#if DEBUG
struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(block: .constant(.init(content: singleApod)), loadedImage: .constant(nil))
    }
}
#endif

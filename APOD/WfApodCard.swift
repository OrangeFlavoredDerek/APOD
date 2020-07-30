//
//  WfApodCard.swift
//  APOD
//
//  Created by Derek Chan on 2020/7/30.
//

import SwiftUI

struct WfApodCard: View {
    @State var block: ApodBlockData
    
    var apod: ApodResult {
        block.content
    }
    
    let aspect: CGFloat = 0.95
    
    let height: CGFloat = 350
    
    var width: CGFloat {
        height * aspect
    }
    
    @State var isPresent: Bool = false
    
    @State var loadedImage: UIImage? = nil
    
    var modal: some View {
        let view = ModalView(block: $block, loadedImage: $loadedImage)
        
        return view
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            VStack {
                if apod.mediaType == .Image {
                    AsyncImage(url: apod.url!, image: $loadedImage)
                        .scaledToFill()
                    
                }else {
                    Image(systemName: "video")
                        .imageScale(.large)
                }
            }
            .frame(width: width, height: height)
            .background(Color.init(.systemGray5))
            
            
            
            VStack(alignment: .leading , spacing: 0) {
                
                Text(apod.getFormatterDate())
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                
                HStack {
                    Text(apod.title)
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                
            }
            .padding([.leading, .trailing], 12)
            .padding([.top, .bottom], 6)
            .background(Background(color: .init(white: 0.4, alpha: 0.2), blur: true))
            
            
        }
        .sheet(isPresented: $isPresent, onDismiss: {
            self.isPresent = false
        }, content: {
            self.modal
        })
        .onTapGesture {
                self.isPresent = true
        }
        .clipped()
        .frame(width: width)
        .cornerRadius(8)
        .shadow(radius: 6)

    }
}

struct WfApodCard_Previews: PreviewProvider {
    static var previews: some View {
        WfApodCard(block: .init(content: arrayApods[0]))
    }
}

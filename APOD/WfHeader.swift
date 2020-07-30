//
//  WfHeader.swift
//  APOD
//
//  Created by Derek Chan on 2020/7/30.
//

import SwiftUI

struct WfHeader: View {
    @State var btnAngle = 180.0
    @Binding var loadState: Bool
    
    var currentDateStr:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, dd"
        return formatter.string(from: .init())
    }
    
    var reloadDelegate: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(currentDateStr.uppercased())//显示当前日期
                .font(.subheadline)
                .bold()
                .foregroundColor(.gray)
            
            HStack {
                Text("APOD")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    reloadDelegate()
                }){
                    Image(systemName: "arrow.2.circlepath.circle")
                        .imageScale(.large)
                        .rotationEffect(Angle(degrees: loadState ? btnAngle : 0))
                        .animation(.easeInOut)
                        .disabled(loadState == true)
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                                if loadState {
                                    btnAngle += 12.0
                                    btnAngle.formTruncatingRemainder(dividingBy: 360)
                                } else {
                                    btnAngle = 180.0
                                }
                            }
                        }
                }
            }
            Divider()
        }
        .padding()
    }
}

#if DEBUG
struct WfHeader_Previews: PreviewProvider {
    static var previews: some View {
        WfHeader(loadState: .constant(false), reloadDelegate: {})
            .previewLayout(.sizeThatFits)
    }
}
#endif

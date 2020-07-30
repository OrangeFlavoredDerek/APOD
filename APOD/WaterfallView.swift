//
//  WaterfallView.swift
//  APOD
//
//  Created by Derek Chan on 2020/7/30.
//

import SwiftUI

struct WaterfallView: View {
    
    @EnvironmentObject var userData: UserData
    
    func reloadSelected() {
        UserData.shared.sendOnlineRequest(delegate: self, type: .refresh)
    }
    
    var selectedContent: Binding<[ApodBlockData]> {
        switch userData.currentLabel {
        case .recent:
            return $userData.localApods
        case .random:
            return $userData.randomApods
        case .saved:
            return $userData.savedApods
        }
    }
    
    var body: some View {
        ScrollView{
            WfHeader(loadState: $userData.isLoading, reloadDelegate: reloadSelected)
                .environmentObject(userData)
                .padding(.bottom, 8)
                .zIndex(100.0)
            
            Picker(selection: $userData.currentLabel, label: Text("Mode"), content: /*@START_MENU_TOKEN@*/{
                ForEach(UserData.WfLabel.allCases, id: \.self){ type in
                    Text(type.rawValue)
                }
            }/*@END_MENU_TOKEN@*/)
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 300)
            .zIndex(100)
            
            
            
            WfLoaderList(apodType: userData.currentLabel, contents: selectedContent)
                .padding(.top, 24)
                .opacity(userData.isLoading ? 0.6 : 1)
        }
    }
}

#if DEBUG
struct WaterfallView_Previews: PreviewProvider {
    static var previews: some View {
        WaterfallView()
            .environmentObject(UserData.shared)
    }
}
#endif


extension WaterfallView: RequestDelegate {
    func requestSuccess(_ apods: [ApodBlockData], _ type: ApodRequest.LoadType) {
        if type == .refresh {
            selectedContent.wrappedValue = apods
        } else {
            selectedContent.wrappedValue.append(contentsOf: apods)
        }
    }
    
    func requestError(_ error: ApodRequest.RequestError) {
        
    }
}

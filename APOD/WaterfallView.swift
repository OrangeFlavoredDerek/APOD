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

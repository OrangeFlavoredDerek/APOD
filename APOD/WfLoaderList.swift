//
//  WfLoaderList.swift
//  APOD
//
//  Created by Derek Chan on 2020/7/30.
//

import SwiftUI
import Combine

struct WfLoaderList: View {
    enum LoadMsgIcon: String {
        case loading = "cloud.rain"
        case empty = "tray"
        case error = "cloud.bolt"
    }
    
    var apodType: UserData.WfLabel
    
    @State var erroeMsg: String = ""
    @State var isError:Bool = false
    @Binding var contents: [ApodBlockData]
    
    var message: (LoadMsgIcon, String) {
        if UserData.shared.isLoading {
            return (LoadMsgIcon.loading, "loading")
        } else {
            if isError {
                return (LoadMsgIcon.error, "error")
            } else {
                return (LoadMsgIcon.empty, "empty")
            }
        }
    }
    
    var body: some View {
        VStack {
            if contents.isEmpty {
                Placeholder(systemName: message.0.rawValue, showTitle: message.1.capitalized)
                    .padding(.top, 180)
                    .onAppear {
                        
                    }
            }
        }
    }
    
    func request(_ type: ApodRequest.LoadType = .refresh) {
        
        isError = false
        
        switch apodType {
        case .recent:
            fallthrough
        case .random:
            UserData.shared.loadHandle?.cancel()
            UserData.shared.isLoading = true
            UserData.shared.sendOnlineRequest(delegate: self, type: type)
        case .saved:
            break
        }
    }
}

extension WfLoaderList: RequestDelegate {
    func requestError(_ error: ApodRequest.RequestError) {
        isError = true
        
        switch error {
        case .Other(let msg):
            let errorMsg = msg
            break
        case .UrlError(let error):
            let errorMsg = error.localizedDescription
            break
        default:
            break
        }
    }
    
    func requestSuccess(_ apods: [ApodBlockData], _ type: ApodRequest.LoadType) {
        isError = false
        
        DispatchQueue.main.sync {
            switch type {
            case .refresh:
                contents = apods
            case .append:
                contents.append(contentsOf: apods)
            }
        }
    }
}

#if DEBUG
struct WfLoaderList_Previews: PreviewProvider {
    static var previews: some View {
        WfLoaderList(apodType: .recent, contents: .constant([]))
    }
}
#endif

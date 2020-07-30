//
//  ContentView.swift
//  APOD
//
//  Created by Derek Chan on 2020/7/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            WaterfallView()
                .environmentObject(UserData.shared)
                .tabItem {
                    VStack{
                        Image(systemName: "skew")
                        Text("APOD")
                    }
                }
                .tag(1)
            
            SettingView()
                .environmentObject(UserSetting.shared)
                .tabItem {
                    VStack{
                        Image(systemName: "gear")
                        Text("Setting")
                    }
                }
                .tag(2)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

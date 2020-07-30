//
//  SettingView.swift
//  APOD
//
//  Created by Derek Chan on 2020/7/30.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var set: UserSetting
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    NavigationLink (
                        destination: TextEditor(original: $set.apiKey)) {
                        HStack {
                            Image(systemName: "antenna.radiowaves.left.and.right")
                            Text("API Key")
                                .padding(.trailing, 24)
                            
                            Spacer()
                            
                            Text(set.apiKey)
                                .foregroundColor(.secondary)
                                .truncationMode(.tail)
                        }
                    }
                    Toggle(isOn: $set.loadHdImage) {
                        HStack {
                            Image(systemName: "map")
                            Text("HD Image")
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        UIApplication.shared.open(URL(string: "https://twitter.com/derekchan0407")!, options: [:], completionHandler: nil)
                    }) {
                        HStack {
                            Image(systemName: "heart")
                                .foregroundColor(.primary)
                            Text("Twitter")
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("APOD")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(UserSetting.shared)
    }
}

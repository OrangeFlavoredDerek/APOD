//
//  TextEditor.swift
//  APOD
//
//  Created by Derek Chan on 2020/7/30.
//

import SwiftUI

struct TextEditor: View {
    @Binding var original: String
    @State var copy = ""
    
    var body: some View {
        List{
            Section{
                ScrollView(.horizontal, showsIndicators: false){
                    TextField("Editor", text: $copy)
                }
            }
            
            Section {
                Button(action: {
                    self.original = self.copy
                }) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Update")
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            copy = original
        }
    }
}

#if DEBUG
struct TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        TextEditor(original: .constant("Editor"))
    }
}
#endif

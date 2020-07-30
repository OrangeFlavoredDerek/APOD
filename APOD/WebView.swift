//
//  WebView.swift
//  APOD
//
//  Created by Derek Chan on 2020/7/30.
//

import SwiftUI
import WebKit

//加载网页
struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

#if DEBUG
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(request: .init(url:  URL(string: "https://www.apple.com")!))
    }
}
#endif

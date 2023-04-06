//
//  LoginView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/12.
//

import SwiftUI
import WebKit


struct LoginView: View {
    
    @Binding var showloginSheet:Bool
    
    var body: some View {
        
        ZStack(){
            
            WebView(url: "https://m.weibo.cn")
                .frame(width: 360, height: 520)
            
            Button(action: {
                doSetCookie()
                showloginSheet.toggle()
            }) {
                Label("登陆完成",systemImage: "arrow.rectanglepath")
                    .foregroundColor(.white)
                    .frame(width: 360,height: 40)
                    .background(.orange)
            }
            .buttonStyle(.plain)
            .frame(width: 360,height: 520,alignment: .bottom)
        }
        .frame(width: 360, height: 520)
    }
    
    
    func doSetCookie(){
        let dataStore = WKWebsiteDataStore.default()
        dataStore.httpCookieStore.getAllCookies({ (cookies) in
            for ( cookieProperties ) in cookies {
                HTTPCookieStorage.shared.setCookie(cookieProperties)
            }
        })
    }
}



struct WebView: NSViewRepresentable {
    let url: String
    func makeNSView(context: Context) -> WKWebView {

        guard let url = URL(string: self.url) else {
            return WKWebView()
        }

        let webview = WKWebView()
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X)", forHTTPHeaderField: "User-Agent")
        webview.load(request)

        return webview
    }
    func updateNSView(_ nsView: WKWebView, context: Context) { }
}

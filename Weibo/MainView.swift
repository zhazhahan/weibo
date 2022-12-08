//
//  TwitterApp.swift
//  Twitter
//
//  Created by Jordan Singer on 7/5/20.
//

import SwiftUI
import WebKit

@main

struct TwitterApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}


struct MainView: View {
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView {
            Sidebar()
            Home()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}




struct Sidebar: View {
    @State var selection: Int?
    
    var body: some View {
        
        List(selection: self.$selection) {
            Group {
                NavigationLink {
                    Home()
                } label: {
                    Label("Server", systemImage: "server.rack")
                        .font(.system(size:14))
                        .padding(.vertical,4)
                }
                .badge(4)
            }
            
            
            Group {
                Text("系统")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                NavigationLink {
                    Home()
                } label: {
                    Label("系统设置", systemImage: "slider.horizontal.3")
                        .font(.system(size:14))
                        .padding(.vertical,4)
                }
                
                NavigationLink {
                    Home()
                } label: {
                    Label("用户管理", systemImage: "circle.grid.cross")
                        .font(.system(size:14))
                        .padding(.vertical,4)
                }
                   
            }
        }
        .padding(.top,30)
        .listStyle(SidebarListStyle())
        .background(Image("menu_bg").blur(radius: 5))
        .frame(minWidth: 220, idealWidth: 220, maxWidth: 220, maxHeight: .infinity)
    }
}

struct SystemView:View{
    var body: some View{
        Text("懒得写...")
    }
    
}


struct UserView:View{
    var body: some View{
        Text("懒得写...")
    }
}

struct GView<Content: View>: View {

    let content: () -> Content
    
    var body: some View {
        return
            content()
            .frame(minWidth:880)
            //.background(Color.yellow.opacity(0.2))
    }
}



struct WebView: NSViewRepresentable {
    let url: String
    func makeNSView(context: Context) -> WKWebView {

        guard let url = URL(string: self.url) else {
            return WKWebView()
        }

        let webview = WKWebView()
        let request = URLRequest(url: url)
        webview.load(request)

        return webview
    }
    func updateNSView(_ nsView: WKWebView, context: Context) { }
}


struct LoginView: View {
    
    @Binding var showloginSheet:Bool
    
    var body: some View {
        
        ZStack(){
            
            WebView(url: "https://m.weibo.cn")
                .padding()
                .frame(width: 480, height: 600)
            
            
            Button(action: {
                doSetCookie()
                showloginSheet.toggle()
            }) {
                Label("完成",systemImage: "arrow.rectanglepath")
                    .frame(width: 480,height: 40,alignment: .bottom)
            }
        }
    }
    
    
    func doSetCookie(){
        let dataStore = WKWebsiteDataStore.default()
        dataStore.httpCookieStore.getAllCookies({ (cookies) in
            //print("---------cookies---------",cookies)
            for ( cookieProperties ) in cookies {
                print("---------cookieProperties---------",cookieProperties)
                    HTTPCookieStorage.shared.setCookie(cookieProperties)
            }
        })
    }
}


struct EmptyView: View {
    var body: some View {
        Text("Hello")
    }
}

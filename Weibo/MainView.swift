//
//  TwitterApp.swift
//  Twitter
//
//  Created by Jordan Singer on 7/5/20.
//

import SwiftUI
import WebKit
import AttributedText
@main

struct TwitterApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        

        WindowGroup("My Info Window") {
            InfoView()
        }
        .handlesExternalEvents(matching: ["infowindow"])
        
    }
    
    init() {
        
        // 配置富文本
        AttributedText.tags = [
            "b": { $0.bold().foregroundColor(.blue.opacity(0.7)) },
            "i": { $0.italic() }
        ]
    }
}




struct InfoView: View {
    var body: some View {
        Text("Some text goes here")
            .padding(60)
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
    
    
    @State private var showloginSheet = false
    
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading){
                List(selection: self.$selection) {
                    Group {
                        NavigationLink {
                            Home()
                        } label: {
                            Label("时间线", systemImage: "server.rack")
                                .font(.system(size:14))
                                .padding(.vertical,4)
                        }
                    }
                    
                    
                    Group {
                        NavigationLink {
                            MessageView()
                        } label: {
                            Label("消息", systemImage: "bubble.left")
                                .font(.system(size:14))
                                .padding(.vertical,4)
                        }
                        .badge(4)
                        
                        NavigationLink {
                            Search()
                        } label: {
                            Label("搜索", systemImage: "slider.horizontal.3")
                                .font(.system(size:14))
                                .padding(.vertical,4)
                        }
                        
                        
                        NavigationLink {
                            AttentionView()
                        } label: {
                            Label("收藏", systemImage: "archivebox")
                                .font(.system(size:14))
                                .padding(.vertical,4)
                        }
                        
                        NavigationLink {
                            MyWeibo()
                        } label: {
                            Label("我的", systemImage: "circle.grid.cross")
                                .font(.system(size:14))
                                .padding(.vertical,4)
                        }
                        
                        
                        NavigationLink {
                            ProfileView(uid: 1744050387)
                        } label: {
                            Label("关注", systemImage: "moon.stars")
                                .font(.system(size:14))
                                .padding(.vertical,4)
                        }
                    }
                }
                .listStyle(SidebarListStyle())
                
                
                Button(action: {
                    showloginSheet.toggle()
                }) {
                    HStack(spacing: 6){
                        Image(systemName:"person.crop.circle.fill").resizable().frame(width: 24,height: 24)
                        Text("角瓦尼")
                    }
                }
                .padding(.horizontal,20)
                .frame(width: proxy.size.width,alignment: .leading)
                .buttonStyle(.plain)
                //.background(.pink)
                .sheet(isPresented: $showloginSheet ) {
                    LoginView(showloginSheet:$showloginSheet)
                }
            }
        }
        .padding(.top,30)
        .padding(.bottom,10)
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
    }
}


struct EmptyView: View {
    var body: some View {
        Text("Hello")
    }
}

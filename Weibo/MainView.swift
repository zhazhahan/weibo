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
                    Label("时间线", systemImage: "server.rack")
                        .font(.system(size:14))
                        .padding(.vertical,4)
                }
                .badge(4)
            }
            
            
            Group {
                
                NavigationLink {
                    Home()
                } label: {
                    Label("搜索", systemImage: "slider.horizontal.3")
                        .font(.system(size:14))
                        .padding(.vertical,4)
                }
                
                NavigationLink {
                    Home()
                } label: {
                    Label("我的", systemImage: "circle.grid.cross")
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
    }
}









struct EmptyView: View {
    var body: some View {
        Text("Hello")
    }
}

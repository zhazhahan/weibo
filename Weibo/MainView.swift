//
//  TwitterApp.swift
//  Twitter
//
//  Created by Jordan Singer on 7/5/20.
//

import SwiftUI
import WebKit
import StackNavigationView
import AttributedText
@main
struct WeiboApp: App {
    
    var body: some Scene {
        WindowGroup {
            Main()
        }
    }
    
    init() {
        // 配置富文本
        AttributedText.tags = [
            "b": { $0.bold().foregroundColor(.blue.opacity(0.7)) },
            "i": { $0.italic() }
        ]
    }
}



struct Main: View {

    @State private var selection: Int? = 0

    @State private var showloginSheet = false


    var body: some View {

        return StackNavigationView(selection: $selection) {

            VStack(alignment: .leading){


                List {
                    SidebarNavigationLink("首页", destination: Home(), tag: 0, selection: $selection)
                    SidebarNavigationLink("搜索", destination: Search(), tag: 1, selection: $selection)
                    SidebarNavigationLink("关注", destination: Attention(), tag: 2, selection: $selection)
                    //SidebarNavigationLink("我的", destination: Me(), tag: 3, selection: $selection)
                }

                Spacer()

                Button(action: {
                    showloginSheet.toggle()
                }) {
                    HStack(spacing: 6){
                        Image(systemName:"person.crop.circle.fill").resizable().frame(width: 24,height: 24)
                        Text("登陆")
                    }
                }
                .sheet(isPresented: $showloginSheet ) {
                    LoginView(showloginSheet:$showloginSheet)
                }
                .buttonStyle(.plain)
                .padding()
            }
            .background(Image("blue"))



            .frame(minWidth: 220, idealWidth: 220, maxWidth: 220, maxHeight: .infinity)

            Text("Empty Selection")
        }
    }
}


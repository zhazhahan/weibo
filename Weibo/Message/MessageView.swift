//
//  MessageView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/14.
//

import SwiftUI

struct MessageView: View {

    @State var loading:Bool = false
    
    var body: some View {
        ScrollView(){
            TabView {
                Text("@我").background(.white)
                    .tabItem {
                        Image(systemName: "at")
                        Text("@我")
                    }
                
                Text("评论")
                    .tabItem {
                        Image(systemName: "at")
                        Text("评论")
                    }
                Text("点赞")
                    .tabItem {
    //                    Image(systemImage: "hand.thumbsup")
                        Text("赞")
                    }
                
                Text("转发")
                    .tabItem {
    //                    Image(systemImage: "arrow.2.squarepath")
                        Text("转发")
                    }
            }
            //.background(.pink)
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(loading ?  "Loading..." : "热门搜索")
        .background(Color.white)
        .toolbar {
            ToolbarItem(placement: .status) {
                Button(action: {
                    initData()
                }) {
                    Image(systemName: "goforward")
                }
            }
        }
    }
    
    func initData() {
        
    }
}


struct ReceivedView: View {
    var body: some View {
        Text("@我")
    }
}


//
//  MessageView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/14.
//

import SwiftUI

struct Message: View {

    @State var loading:Bool = false
    
    var body: some View {
        ScrollView(){
            
            HStack(){
                HStack(){
                    Button(action: {
                        
                    }, label: {
                        Text("@我").font(.title3).foregroundColor(.orange)
                    })
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("评论").font(.title3).foregroundColor(.gray)
                    })
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("点赞").font(.title3).foregroundColor(.gray)
                    })
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("转发").font(.title3).foregroundColor(.gray)
                    })
                    .buttonStyle(.plain)
                }
                .padding(.vertical,20)
                .padding(.horizontal,10)
                Spacer()
            }
            .frame(alignment: .leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(loading ?  "Loading..." : "消息")
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


//
//  IndexView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/9.
//

import SwiftUI

struct MyWeibo: View {
    
    @State var loading:Bool = false
    @State var data:[Weibo] = []
    @State private var selectedShow: TVShow?
    
    
    @State private var showloginSheet = false
    

    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(data) { tweet in
                    FeedItemView(weibo: tweet)
                        .padding()
                    Divider()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(loading ?  "Loading..." : "首页")
        .background(Color.white)
        .toolbar {
            ToolbarItem(placement: .status) {
                Button(action: {
                    showloginSheet.toggle()
                }) {
                    Image(systemName: "person.crop.circle.fill")
                }
                .sheet(isPresented: $showloginSheet ) {
                    LoginView(showloginSheet:$showloginSheet)
                }
            }
            
            ToolbarItem(placement: .status) {
                Button(action: {
                    initData()
                }) {
                    Image(systemName: "goforward")
                }
            }
            
        }
        .task{
            initData()
        }
        .alert(item: $selectedShow) { show in
            Alert(title: Text("提示"), message: Text(show.msg), dismissButton: .cancel())
        }
    }
    
    func initData() {
        Task{
            loading = true
            Api().getMyWeibo(page: 1, user_id: 2){(res) in
                data = res.data.statuses
                loading = false
                //print("initData",res)
            }
        }
    }
    
    
    

    
    func syncData(){

    }
}



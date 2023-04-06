//
//  IndexView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/9.
//

import SwiftUI
import StackNavigationView


struct Home: View {

    @State var tips:Bool = false

    @State var loading:Bool = false
    @State var page:Int = 1
    @State var max_id:Int?


    
    @State var data:[Weibo] = []
    @State private var selectedShow: TVShow?

    var body: some View {
        ScrollView {

            if( tips ){
                Text("😼 请登录，并在登录成功后点击[登录完成]按钮.")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .padding(.top,200)
            }


            VStack(spacing: 0) {
                ForEach(data) { tweet in
                    FeedItemView(weibo: tweet).padding()
                    Divider()
                }
            }
            
            // 下一页
            if( !loading && data.count > 0 ){
                Button(action: {
                    page+=1
                    initData()
                }) {
                    Text("下一页")
                }
                .padding()
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(loading ?  "Loading..." : "首页")
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
        .task{
            initData()
        }
        .alert(item: $selectedShow) { show in
            Alert(title: Text("提示"), message: Text(show.msg), dismissButton: .cancel())
        }
    }
    
    func refreshData(){
        max_id = nil
        initData()
    }
    
    func initData() {
        Task{
            loading = true
            Api().getWeibos(max_id: max_id){(res) in
                data = res.data.statuses
                max_id = res.data.max_id
                loading = false
            }
            loading = false

//            if( data.count == 0 ){
//                tips = true
//            }
        }
    }
    
    
    

    
    func syncData(){

    }
}



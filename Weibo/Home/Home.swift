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
    @State var max_id:Int?
    
    @State var data:[Weibo] = []
    @State private var selectedShow: TVShow?

    var body: some View {
        VStack(spacing: 0) {
            if( tips ){
                Text("😼 请登录，并在登录成功后点击[登录完成]按钮.")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                    .padding(.top,200)
            }

            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(spacing: 0) {
                        ForEach(data) { tweet in
                            FeedItemView(weibo: tweet).padding()
                            Divider()
                        }
                    }
                    .onChange(of: data) { _ in
                        print("onChange",data.first?.user.screen_name)
                        // 自动到底部
                        proxy.scrollTo(0, anchor: .top)
                    }
                }
            }


            // 下一页
            if( !loading && data.count > 0 ){
                Button(action: {
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
                    refreshData()
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

        print("Max",max_id)

        Task{
            loading = true
            Api().getWeibos(max_id: max_id){(res) in
                data = res.data.statuses
                max_id = res.data.max_id
                loading = false
            }
            loading = false
        }
    }
    
    
    

    
    func syncData(){

    }
}



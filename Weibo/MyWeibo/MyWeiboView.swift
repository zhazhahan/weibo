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

                loading = false

                // 数据处理
                let jsstr = res.cards.filter({ $0.card_type == 9 });
                var myweibo:[Weibo] = []
                for index in 0 ..< jsstr.count-1 {
                    if( jsstr[index].mblog != nil ){
                        if let weiboitem = jsstr[index].mblog {
                            //print(weiboitem.text)
                            myweibo.append(weiboitem)
                        }
                    }
                }
                data = myweibo
                //print("myweibo",myweibo)
                // 关注 https://m.weibo.cn/api/container/getIndex?containerid=231093_-_selffollowed&page=2
            }
        }
    }
    
    
    

    
    func syncData(){

    }
}



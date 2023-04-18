//
//  IndexView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/9.
//

import SwiftUI

struct ProfileView: View {
    
    @State var uid:Int
    @State var loading:Bool = false
    @State var data:[Weibo] = []
    
    
    @State private var showloginSheet = false

    @State var nickname:String = "Profile"

    
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
        .navigationTitle(loading ?  "Loading..." : self.nickname)
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
    }
    
    func initData() {
        Task{
            loading = true
            
            Api().getMyWeibo(page: 1, user_id: uid){(res) in
                loading = false
                
                // 数据处理
                let jsstr = res.cards.filter({ $0.card_type == 9 });
                var myweibo:[Weibo] = []
                for index in 0 ..< jsstr.count-1 {
                    if( jsstr[index].mblog != nil ){
                        if let weiboitem = jsstr[index].mblog {
                            //print(weiboitem.text)
                            myweibo.append(weiboitem)
                            self.nickname = weiboitem.user.screen_name ?? ""
                        }
                    }
                }
                data = myweibo
                
                //print("jsstr",jsstr)
                //print("myweibo",myweibo)
            }
        }
    }
    
    
    

    
    func syncData(){

    }
}



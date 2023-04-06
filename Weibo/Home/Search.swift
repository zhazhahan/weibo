//
//  SearchView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/12.
//

import SwiftUI

//
//  IndexView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/9.
//

import SwiftUI

struct Search: View {
    
    @State var loading:Bool = false
    @State var data:[SearchItem] = []
    @State private var keyword: String = ""

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            
            GeometryReader { geometry in
                HStack(alignment: .top,spacing: 0) {
                    
                    VStack(alignment: .leading,spacing: 30){
                        
                        VStack(alignment: .leading,spacing: 16){
                            Text("🔎 搜索")
                                .font(.title2)
                                .foregroundColor(.orange)
                                .padding(.top,20)
                            
                            TextField(
                                "搜索",
                                text: $keyword
                            )
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.vertical,8)
                            .padding(.horizontal,10)
                            .overlay(
                                RoundedRectangle(cornerRadius:16).stroke(Color.black.opacity(0.2),lineWidth:0.5)
                            )
                        }
                        
                        
                        
//                        Text("📢 超话")
//                            .font(.title2)
//                            .foregroundColor(.orange)
//                            .padding(.vertical,20)
                            
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: geometry.size.width * 0.67,alignment: .topLeading)
                    //.background(.orange.opacity(0.1))
                    
                    
                    
                    VStack(alignment: .leading){
                        Text("🔥 热门搜索")
                            .font(.title2)
                            .foregroundColor(.orange)
                            .padding(.top,20)
                            .padding(.bottom,10)
                        
                        ForEach(data,id: \.self) { item in
                            Button(action: {
                                
                            }, label: {
                                Text("# \(item.title_sub)")
                                    .padding(.bottom,6)
                                    .padding(.leading,6)
                                    .foregroundColor(.orange)
                            })
                            .buttonStyle(.plain)
                        }
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: geometry.size.width * 0.33,alignment: .topLeading)
                }
            }
            
            
            
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
        .task{
            initData()
        }
    }
    
    func initData() {
        Task{
            loading = true
            Api().getHotSearch(page: 1, user_id: 2){(res) in
                data = res.group
                loading = false
                //print("initData",res)
            }
        }
    }
    
    
    

    
    func syncData(){

    }
}



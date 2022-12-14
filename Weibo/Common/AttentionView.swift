//
//  IndexView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/9.
//

import SwiftUI

struct AttentionView: View {
    
    @State var loading:Bool = false
    @State var data:[Int] = []
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            
            Text("🔥 一种关注")
                .font(.title2)
                .foregroundColor(.orange)
                .padding(.top,20)
            
            LazyVGrid(columns: columns){
                ForEach(data, id: \.self) { item in
                    Button(action: {

                        
                    }, label: {
                        
                        HStack{
                            AsyncImage(url: URL(string: "https://tvax1.sinaimg.cn/crop.0.0.512.512.180/c59b2853ly8gc2xbabmprj20e80e8q3j.jpg?KID=imgbed,tva&Expires=1670998169&ssig=xBaaoQqIAU")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.1)
                            }
                            .frame(width: 100,height: 100)
                            
                            //
                            
                            VStack(){
                                Text("月亮与六便士")
                                Spacer()
                                Text("那是我的自由意志").font(.caption2).foregroundColor(.gray)
                                Spacer()
                                Spacer()
                            }
                            .padding()
                            
                            
                            Spacer()
                        }
                    })
                    .buttonStyle(.plain)
                    .clipped()
                    .border(.gray.opacity(0.1))
                    .background(.gray.opacity(0.1))
                    .cornerRadius(5)
                }
            }
            .padding(.vertical,20)
            .padding(.horizontal,40)
            
            
            
            Text("⭐️ 我的收藏")
                .font(.title2)
                .foregroundColor(.orange)
//                .padding(.top,20)
                .padding(.bottom,10)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(loading ?  "Loading..." : "关注")
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
            let attentions = [3315279955,3315349955,515453955,33152676955,331589879955,33152349955];
            print(attentions[2])
            data = attentions
        }
    }
    
    
    

    
    func syncData(){

    }
}



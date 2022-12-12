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
    

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns,spacing: 10){
                ForEach(data,id: \.self) { item in
                    Button(action: {
                        
                    }, label: {
                        Text("# \(item.title_sub)")
                            .padding(.vertical,10)
                            .padding(.leading,10)
                            .foregroundColor(.orange)
                    })
                    .buttonStyle(.plain)
                    .frame(width: 240,alignment: .leading)
                    .background(.yellow.opacity(0.1))
                    .cornerRadius(5)
                    .clipped()
                    .border(.gray.opacity(0.1))
                    
                }
            }
            .padding(.top,40)
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



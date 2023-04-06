//
//  IndexView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/9.
//

import SwiftUI

struct Attention: View {
    
    @State var loading:Bool = false
    @State var data:[Int] = []
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {

        VStack(alignment: .leading){
            Text("开发中...")
                .foregroundColor(.orange)
                .padding()
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
        loading = true
    }
    
    
    

    
    func syncData(){

    }
}



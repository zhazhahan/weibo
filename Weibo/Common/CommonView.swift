//
//  CommonView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/9.
//

import SwiftUI






struct PreviewView: View {
    var window = NSScreen.main?.visibleFrame

    var imgs:[WeiboPic] = []
    @State var index:Int = 0
    @State var cimg:String = ""
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {

        VStack(){
            ScrollView(){
                AsyncImage(url: URL(string:cimg )) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.1).frame(width: 340,height: 340)
                }
                .frame(width:340)
                //.background(.pink)
            }
            .frame(idealWidth: 340,maxWidth: 340, maxHeight: 520)
            

            Spacer()
            
            HStack(){
                Button("上一张") {
                    showPre()
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("关闭").foregroundColor(.blue)
                })
                .buttonStyle(.plain)
                
                Button("下一张") {
                    showNext()
                }
                .buttonStyle(.plain)
            }
            .frame(width: 340,height: 40)
        }
        .frame(width: 340)
        .task{
            //Init
            cimg = imgs[index].large.url
        }
    }
    
    func showNext(){
        index = index+1
        if( index >= imgs.count ){
            index = imgs.count-1
        }
        cimg = imgs[index].large.url
    }
    
    func showPre(){
        index = index-1
        if( index < 0 ){
            index = 0
        }
        cimg = imgs[index].large.url
    }
}




struct LikeView: View {
    @Binding var showLikeWindow: Bool
    
    @State var likes:[Like]
    
    var body: some View {
        ScrollView() {
            ForEach(likes, id: \.self) { litem in
                HStack(spacing: 10){
                    AsyncImage(url: URL(string: litem.avatar_path)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.1)
                    }
                    .frame(width: 30,height: 30)
                    .cornerRadius(30)
                    .clipped()
                    
                    
                    VStack(alignment: .leading){
                        Text(litem.nickname).font(.custom("like", size: 12)).padding(.bottom,1)
                        
                        Text(litem.source).font(.custom("like", size: 10)).foregroundColor(.gray)
                    }
                    .frame(width:130,height: 40,alignment: .leading)
                    

                    Image(systemName: "heart")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.pink)
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    
                }
                .frame(width:230)
                .padding(.vertical,4)
                .padding(.horizontal,5)
            }
        }
        .frame(width: 230, height: 190)
    }
}


struct CommentView: View {
    @Binding var showCommentWindow: Bool
    
    @State var comments:[Comment]
    
    var body: some View {
        ScrollView() {
            ForEach(comments, id: \.self) { citem in
                HStack(){
                    AsyncImage(url: URL(string: citem.avatar_path)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.1)
                    }
                    .frame(width: 32,height: 32)
                    .cornerRadius(32)
                    .clipped()
                    .padding(10)
                    
                    Spacer()
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text(citem.nickname).font(.custom("like", size: 12)).foregroundColor(.gray)
                        Text(citem.text).font(.custom("like", size: 14))
                    }
                    .frame(width:280,height: 60,alignment: .leading)
                }
                .padding(.horizontal,8)
            }
        }
        .frame(width: 350, height: 190)
    }
}


struct RetweetView: View {
    @Binding var showRetweetWindow: Bool
    var body: some View {
        VStack(spacing: 0) {
            Text("RetweetView")
        }
        .frame(width: 256, height: 192)
    }
}

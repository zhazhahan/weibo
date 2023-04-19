//
//  CommonView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/9.
//

import SwiftUI
import Kingfisher

struct PreviewView: View {
    var window = NSScreen.main?.visibleFrame

    var imgs:[WeiboPic] = []
    @Binding var index:Int
    @State var cimg:String = ""
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {


        VStack(){
                HStack(){
                    Spacer()

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                    .buttonStyle(.plain)
                    .font(.largeTitle)
                    .padding()
                }

                KFImage(URL(string:cimg))
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .gray.opacity(0.3),radius: 1)
                    .padding()


                HStack(alignment: .top){

                    Button(action: {
                        showPre()
                    }, label: {
                        Text("上一张")
                    })
                    .foregroundColor( index != 0  ? .blue : .gray)
                    .buttonStyle(.plain)

                    Text("\(index+1) / \(self.imgs.count)")
                        .foregroundColor(.gray.opacity(0.8))



                    Button(action: {
                        showNext()
                    }, label: {
                        Text("下一张")
                    })
                    .foregroundColor( index < imgs.count-1 ? .blue : .gray)
                    .buttonStyle(.plain)
                }
                .frame(width: 280,height: 40)
                //.background(.white)
                .padding(.horizontal)

        }

        .frame(idealWidth: ( NSApp.keyWindow?.contentView?.bounds.width ?? 400) - 100, idealHeight: ( NSApp.keyWindow?.contentView?.bounds.height ?? 300 ) - 100 )
        .background(.clear)
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




struct WeiboView: View {

    var weibo: Weibo
    @State var likes:[Like] = []
    @State var loading:Bool = false
    @State var title:String = "微博"
    
    var body: some View {
        ScrollView() {
            FeedItemView(weibo: weibo).padding()

            VStack(alignment: .leading){
                Text("评论")
                Divider()
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(loading ?  "Loading..." : self.title)
        .background(Color.white)
        .toolbar {
            ToolbarItem(placement: .status) {
                Button(action: {

                }) {
                    Image(systemName: "goforward")
                }
            }
        }
        .task{

        }
    }
}

//
//struct CommentView: View {
//    @Binding var showCommentWindow: Bool
//    
//    @State var comments:[Comment]
//    
//    var body: some View {
//        ScrollView() {
//            ForEach(comments, id: \.self) { citem in
//                HStack(){
//                    AsyncImage(url: URL(string: citem.avatar_path)) { image in
//                        image
//                            .resizable()
//                            .scaledToFill()
//                    } placeholder: {
//                        Color.gray.opacity(0.1)
//                    }
//                    .frame(width: 32,height: 32)
//                    .cornerRadius(32)
//                    .clipped()
//                    .padding(10)
//                    
//                    Spacer()
//                    
//                    VStack(alignment: .leading,spacing: 4){
//                        Text(citem.nickname).font(.custom("like", size: 12)).foregroundColor(.gray)
//                        Text(citem.text).font(.custom("like", size: 14))
//                    }
//                    .frame(width:280,height: 60,alignment: .leading)
//                }
//                .padding(.horizontal,8)
//            }
//        }
//        .frame(width: 350, height: 190)
//    }
//}
//
//
//struct RetweetView: View {
//    @Binding var showRetweetWindow: Bool
//    var body: some View {
//        VStack(spacing: 0) {
//            Text("RetweetView")
//        }
//        .frame(width: 256, height: 192)
//    }
//}

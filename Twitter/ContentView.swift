//
//  ContentView.swift
//  Twitter
//
//  Created by Jordan Singer on 7/5/20.
//

import SwiftUI
import Alamofire
import SwiftyJSON


struct ContentView: View {
    @State var selection: Set<Int> = [0]
    
    var body: some View {
        NavigationView {
            List(selection: self.$selection) {
                Label("微博", systemImage: "house.fill")
                    .tag(0)
                Label("搜索", systemImage: "magnifyingglass")
                Label("消息", systemImage: "envelope")
                Label("我的", systemImage: "person")
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 220, idealWidth: 220, maxWidth: 256, maxHeight: .infinity)
            
            Home()
        }
    }
}
struct TVShow: Identifiable {
    var id: String { msg }
    let msg: String
}


struct Home: View {
    
    @State var loading:Bool = false
    
    @State var data:[Weibo] = []
    
    
    @State private var selectedShow: TVShow?
    
    var body: some View {
        Feed(data:data)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(loading ?  "Loading..." : "首页")
        .background(Color.white)
        .toolbar {
            ToolbarItem(placement: .status) {
                Button(action: {
                    syncData()
                }) {
                    Image(systemName: "clock.arrow.2.circlepath")
                }
            }
            
            ToolbarItem(placement: .status) {
                Button(action: {
                    initData()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            
        }
        .task{
            // 初始化数据
            if( data.count == 0 ){
                initData()
            }
        }
        .alert(item: $selectedShow) { show in
            Alert(title: Text("提示"), message: Text(show.msg), dismissButton: .cancel())
        }
    }
    
    func initData() {
        Task{
            loading = true
            Api().getWeibos(page: 1, user_id: 2){(res) in
                data = res.data
                loading = false
                print("initData")
            }
        }
    }
    

    
    func syncData(){
        Task{
            loading = true
            Api().syncData(user_id: 2){(res) in
                print("syncData",res)
                loading = false
                selectedShow = TVShow(msg:res.msg+",新增了\(res.count)条数据")
                //SPAlert.present(title:res.msg, preset:.error)
            }
        }
    }
}

struct Rsp:Codable{
    var code:Int
    var count:Int
    var msg:String
}


struct WeiboRsp:Codable{
    var code:Int
    var data:[Weibo]
}

struct Weibo:Codable,Identifiable{
    
    var id:Int
    
    let text:String
    let created_at:String
    
    
    let user_avatar_path:String
    let user_screen_name:String
    
    let retweet_text:String
    //let retweet_user_screen_name:String?
    
    let img:[Img]
    
    
    let like:[Like]
    let comment:[Comment]
    let retweet:[Retweet]
}
struct Like:Codable,Hashable{
    let nickname:String
    let avatar_path:String
    let source:String
}
struct Comment:Codable,Hashable{
    let text:String
    let nickname:String
    let avatar_path:String
}
struct Retweet:Codable,Hashable{
    let text:String
    let nickname:String
    let avatar_path:String
}

struct Img:Codable,Hashable{
    let weibo_large:String?
    let oss:String?
}

struct Feed: View {
    var data:[Weibo]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(data) { tweet in
                    Tweet(weibo: tweet)
                        .padding()
                    Divider()
                }
            }
        }
    }
}

struct PreviewView: View {
    
    var imgs:[Img] = []
    @State var index:Int = 0
    @State var cimg:String = ""
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {

        VStack(){
            AsyncImage(url: URL(string:cimg )) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            .frame(width: 340)

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
        //.frame(width: 340)
        .task{
            //Init
            cimg = imgs[index].weibo_large ?? ""
        }
    }
    
    func showNext(){
        index = index+1
        if( index >= imgs.count ){
            index = imgs.count-1
        }
        cimg = imgs[index].weibo_large ?? ""
    }
    
    func showPre(){
        index = index-1
        if( index < 0 ){
            index = 0
        }
        cimg = imgs[index].weibo_large ?? ""
    }
}


struct Tweet: View {
    @State var weibo: Weibo
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var showingSheet = false
    
    
    @State var showLikeWindow = false
    @State var showCommentWindow = false
    @State var showRetweetWindow = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            AsyncImage(url: URL(string: weibo.user_avatar_path)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            .frame(width: 40,height: 40)
            .cornerRadius(40)
            .clipped()
            
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline) {
                    Text(weibo.user_screen_name)
                        .font(.title3)
                        .fontWeight(.semibold)
        
                    
                    Text(weibo.created_at)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Text(weibo.text)
                    .font(.title3)
                    .foregroundColor(.primary)
                
                if( weibo.retweet_text.count > 0 ){
                    Text( "："+weibo.retweet_text )
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(5)
                        .clipped()
                }
            
                
                if( weibo.img.count > 0 ){
                    Spacer()
                    
                    LazyVGrid(columns: columns,spacing: 10){
                        ForEach(weibo.img, id: \.self) { img in
                            Button(action: {
                                showingSheet.toggle()
                            }, label: {
                                AsyncImage(url: URL(string: img.weibo_large ?? "")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.1)
                                }
                                .frame(width: 100,height: 100)
                            })
                            .frame(width: 100,height: 100)
                            .buttonStyle(.plain)
                            .cornerRadius(5)
                            .clipped()
                            .border(.gray)
                            .sheet(isPresented: $showingSheet ) {
                                PreviewView(imgs: weibo.img)
                            }
                        }
                    }
                    .frame(width: 340)
                    //.background(.pink)
                }
                
                HStack(spacing: 20) {
                    
                    Button(action: { self.showLikeWindow = true }) {
                        Label("\(weibo.like.count)",systemImage: "heart")
                    }
                    .popover(isPresented: $showLikeWindow) {
                        LikeView(showLikeWindow: $showLikeWindow,likes: weibo.like)
                    }
                    .buttonStyle(.link)
                    
                    
                    
                    Button(action: { self.showCommentWindow = true }) {
                        Label("\(weibo.comment.count)",systemImage: "bubble.right")
                    }
                    .popover(isPresented: $showCommentWindow) {
                        CommentView(showCommentWindow: $showCommentWindow,comments: weibo.comment)
                    }
                    .buttonStyle(.link)
                    
                    
                    Button(action: { self.showRetweetWindow = true }) {
                        Label("\(weibo.retweet.count)",systemImage: "arrow.2.squarepath")
                    }
                    .popover(isPresented: $showRetweetWindow) {
                        RetweetView(showRetweetWindow: $showRetweetWindow)
                    }
                    .buttonStyle(.link)
                    
                    
                    
                    
                    
                    
                }
                .padding(.top, 12)
                .font(.title3)
                .foregroundColor(.secondary)
            }
            
            Spacer()
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

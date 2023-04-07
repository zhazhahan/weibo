//
//  FeedItemView.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/9.
//

import SwiftUI
import AttributedText
import StackNavigationView
import Kingfisher

struct FeedItemView: View {
    @State var weibo: Weibo
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var showingSheet = false
    @State var index:Int = 0
    
    @State var showLikeWindow = false
    @State var showCommentWindow = false
    @State var showRetweetWindow = false
    @State var selection: Int?
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {

                StackNavigationLink(destination:
                    ProfileView(uid: weibo.user.id)
                , label: {
                    KFImage(URL(string: weibo.user.avatar_hd))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40,height: 40)
                        .cornerRadius(40)
                        .clipped()
                })
                .buttonStyle(.plain)
                .frame(width: 40,height: 40)
                

                
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(weibo.user.screen_name)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top,2)
                    }
                    
                    
                    HStack(spacing: 10){
                        Text("\(weibo.dateString)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("来自 \(weibo.source)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom,10)
                    
                    Text(weibo.text_raw)
                        .font(.title3)
                        //.frame(width: proxy.size.width)
                        .foregroundColor(.primary)
                    
                    if( weibo.retweeted_status != nil ){


                        VStack(alignment: .leading){
                            StackNavigationLink(destination:
                                 ProfileView(uid: weibo.retweeted_status?.user?.id ?? 0)
                            , label: {
                                Text("\(weibo.retweeted_status?.user?.screen_name ?? "")")
                                    .font(.title3)
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                    .padding(.horizontal,10)
                            })
                            .buttonStyle(.link)


                            AttributedText( "\(weibo.retweeted_status?.text_raw ?? "")" )
                                .font(.title3)
                                .foregroundColor(.primary)
                                .padding(.horizontal,10)
                        }
                        .padding(.vertical,10)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(5)
                        .clipped()
                        
                        // IMG
                        if( weibo.retweeted_status?.pics != nil ){
                            Spacer()
                            LazyVGrid(columns: columns,spacing: 10){
                                ForEach(weibo.retweeted_status?.pics ?? [], id: \.self) { img in
                                    Button(action: {
                                        self.index = 0
                                        showingSheet.toggle()
                                    }, label: {
                                        KFImage(URL(string:img.url))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100,height: 100)
                                    })
                                    .tag(1)
                                    .frame(width: 100,height: 100)
                                    .buttonStyle(.plain)
                                    .cornerRadius(5)
                                    .clipped()
                                    .border(.gray.opacity(0.1))
                                    .sheet(isPresented: $showingSheet ) {
                                        PreviewView(imgs: weibo.retweeted_status?.pics ?? [],index: $index)
                                    }
                                }
                            }
                            .frame(width: 340)
                            //.background(.pink)
                        }
                    }
                    
                    
                    
                    if( weibo.pics != nil ){
                        Spacer()
                        LazyVGrid(columns: columns,spacing: 10){
                            ForEach(weibo.pics ?? [], id: \.self) { img in
                                Button(action: {
                                    self.index = 0
                                    showingSheet.toggle()
                                }, label: {
                                    KFImage(URL(string:img.url))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100,height: 100)
                                        .clipped()
                                })
                                .frame(width: 100,height: 100)
                                .buttonStyle(.plain)
                                .cornerRadius(5)
                                .clipped()
                                .border(.gray.opacity(0.1))
                                .sheet(isPresented: $showingSheet ) {
                                    PreviewView(imgs: weibo.pics ?? [],index: $index)
                                }
                            }
                        }
                        .frame(width: 340)
                        //.background(.pink)
                    }
                    
                    HStack(spacing: 20) {
                        
                        Button(action: { self.showLikeWindow = true }) {
                            Label("\(weibo.attitudes_count)",systemImage: "hand.thumbsup")
                        }
                        .popover(isPresented: $showLikeWindow) {
                            //LikeView(showLikeWindow: $showLikeWindow,likes: weibo.like)
                        }
                        .buttonStyle(.link)
                        
                        
                        Button(action: { self.showCommentWindow = true }) {
                            Label("\(weibo.comments_count)",systemImage: "bubble.right")
                        }
                        .popover(isPresented: $showCommentWindow) {
                            //CommentView(showCommentWindow: $showCommentWindow,comments: weibo.comment)
                        }
                        .buttonStyle(.link)
                        
                        
                        Button(action: { self.showRetweetWindow = true }) {
                            Label("\(weibo.reposts_count ?? 0)",systemImage: "arrow.2.squarepath")
                        }
                        .popover(isPresented: $showRetweetWindow) {
                            //RetweetView(showRetweetWindow: $showRetweetWindow)
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


//
//  Weibo.swift
//  Weibo
//
//  Created by 韩炸炸 on 2022/12/13.
//

import Foundation


struct TVShow: Identifiable {
    var id: String { msg }
    let msg: String
}

struct HotSearch:Codable{
    var group:[SearchItem]
}

struct SearchItem:Codable,Hashable{
    var title_sub:String
}

struct ProfileRsp:Codable{
    var cards:[MyWeiboItem]
}

struct MyWeiboRsp:Codable{
    var cards:[MyWeiboItem]
}

struct MyWeiboItem:Codable{
//    var id = UUID()
    var card_type:Int
    var mblog:Weibo?
}

struct WeiboRsp:Codable{
    var ok:Int
    var http_code:Int
    var data:WeiboData
}

struct WeiboData:Codable{
    var statuses:[Weibo]
    var max_id:Int?
}

struct Weibo:Codable,Identifiable,Hashable{
    
    var id:String
    
    let text:String
    var text_raw:String{
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [])
        let range = NSRange(text.startIndex..., in: text)
        let modifiedString = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
        return modifiedString
    }
    let source:String
    let created_at:String
    
    var dateString: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "E M d h:m:s z yyyy"
        if let date = dateFormater.date(from: created_at){
            let dformatter = DateFormatter()
            dformatter.dateFormat = "MM-dd"
            return dformatter.string(from: date)
        }else{
            return "00-00"
        }
    }
    
    let retweeted_status:Retweeted?
    
    let user:WeiboUser

    var liked:Bool?
    
    let attitudes_count:Int
    let comments_count:Int
    let reposts_count:Int?
    
    let pics:[WeiboPic]?
}
struct WeiboPic:Codable,Hashable{
    var pid:String
    let url:String
    let large:WeiboPicLarge
}

struct WeiboPicLarge:Codable,Hashable{
    let url:String
}

struct Retweeted:Codable,Hashable{
    let text:String
    var text_raw:String{
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [])
        let range = NSRange(text.startIndex..., in: text)
        let modifiedString = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
        return modifiedString
    }
    let created_at:String
    let user:WeiboUser?
    
    let pics:[WeiboPic]?
}


struct WeiboUser:Codable,Hashable{
    let screen_name:String
    let avatar_hd:String
    let id:Int
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

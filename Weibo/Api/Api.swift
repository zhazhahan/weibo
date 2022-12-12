//
//  ApiRequest.swift
//  TV Demo App
//
//  Created by 韩炸炸 on 2022/11/3.
//

import Alamofire
import SwiftyJSON
import Foundation
import CryptoKit


enum ApiConfig {
    static let baseurl = "https://m.weibo.cn"
}


class Api{
    


    let defaults = UserDefaults.standard
    let cookieStorage = HTTPCookieStorage.shared

    func getCookie(forURL url: String) -> [HTTPCookie] {
        let computedUrl = URL(string: url)
        let cookies = cookieStorage.cookies(for: computedUrl!) ?? []
        print("cookie",cookies)
        return cookies
    }
    
    
    func backupCookies() {
        var cookieDict = [String: AnyObject]()
        for cookie in cookieStorage.cookies ?? [] {
            cookieDict[cookie.name] = cookie.properties as AnyObject?
        }
        //print("save cookie cookieDict ",cookieDict)
        defaults.set(cookieDict, forKey: "SavedCookie")
    }

    func removeCookie() {
        defaults.removeObject(forKey: "SavedCookie")
    }

    func restoreCookies() {
        if let cookieDictionary = defaults.dictionary(forKey: "SavedCookie") {
            for (_, cookieProperties) in cookieDictionary {
                if let cookie = HTTPCookie(properties: cookieProperties as! [HTTPCookiePropertyKey: Any]) {
                    cookieStorage.setCookie(cookie)
                }
            }
        }
    }
    
    func saveCookie(list: [HTTPCookie]) {
        list.forEach({ cookieStorage.setCookie($0) })
        backupCookies()
    }
    
    // Hot Search
    func getHotSearch(page:Int,user_id:Int,completion: @escaping (HotSearch) -> Void) {
        let parameters:[String:Any] = [
            "Accept":"application/json",
            "user-agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)",
            "containerid":"231583",
            "page_type":"searchall"
        ]
        AF.request(ApiConfig.baseurl+"/api/container/getIndex",parameters: parameters).validate().responseData { (response) in
            do {
                let jsdata =  JSON(response.data)
                //print("jsdata",jsdata["data"]["cards"][0] )
                let ff  = try jsdata["data"]["cards"][0].rawData()
                let object = try JSONDecoder().decode(HotSearch.self, from: ff)
                completion(object)
            }catch(let error) {
                print("decode fail:",error)
            }
        }
    }
    
    
    // Timeline
    func getWeibos(page:Int,user_id:Int,completion: @escaping (WeiboRsp) -> Void) {
        let parameters:[String:Any] = [
            "Accept":"application/json",
            "user-agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
        ]
        AF.request(ApiConfig.baseurl+"/feed/friends",parameters: parameters).validate().responseData { (response) in
            do {
                let jsdata =  JSON(response.data)
                //print(jsdata["data"])
                let ff  = try jsdata.rawData()
                let object = try JSONDecoder().decode(WeiboRsp.self, from: ff)
                completion(object)
            }catch(let error) {
                print("decode fail:",error)
            }
        }
    }
    
    
    // Timeline
    func getMyWeibo(page:Int,user_id:Int,completion: @escaping (WeiboRsp) -> Void) {
        let parameters:[String:Any] = [
            "MWeibo-Pwa":"1",
            "Accept":"application/json",
            "user-agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
        ]
        AF.request(ApiConfig.baseurl+"/profile/info?uid=2103403282",parameters: parameters).validate().responseData { (response) in
            do {
                let jsdata =  JSON(response.data)
                print(jsdata)
//                let ff  = try jsdata.rawData()
//                let object = try JSONDecoder().decode(WeiboRsp.self, from: ff)
//                completion(object)
            }catch(let error) {
                print("decode fail:",error)
            }
        }
    }
    
    
    
    
    

}

struct TVShow: Identifiable {
    var id: String { msg }
    let msg: String
}




struct Rsp:Codable{
    var code:Int
    var count:Int
    var msg:String
}




struct HotSearch:Codable{
    var group:[SearchItem]
}

struct SearchItem:Codable,Hashable{
    var title_sub:String
}





struct WeiboRsp:Codable{
    var ok:Int
    var http_code:Int
    var data:WeiboData
}

struct WeiboData:Codable{
    var statuses:[Weibo]
}

struct Weibo:Codable,Identifiable{
    
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
    
    
    let attitudes_count:Int
    let comments_count:Int
    let reposts_count:Int
    
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

struct Retweeted:Codable{
    let text:String
    var text_raw:String{
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [])
        let range = NSRange(text.startIndex..., in: text)
        let modifiedString = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
        return modifiedString
    }
    let created_at:String
    let user:WeiboUser
}


struct WeiboUser:Codable{
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

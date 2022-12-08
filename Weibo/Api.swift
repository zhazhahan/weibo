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
    

    //
    func getWeibos(page:Int,user_id:Int,completion: @escaping (WeiboRsp) -> Void) {
        
        let parameters:[String:Any] = ["Accept":"application/json","user-agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"]
        AF.request(ApiConfig.baseurl+"/feed/friends",parameters: parameters).validate().responseData { (response) in
            do {
                let jsdata = JSON(response.data)
                //let ff  = try jsdata.rawData()
                print("jsdata:",jsdata)
            }catch(let error) {
                print("decode fail:",error)
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

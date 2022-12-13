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

    // Hot Search
    func getHotSearch(page:Int,user_id:Int,completion: @escaping (HotSearch) -> Void) {
        let parameters:[String:Any] = [
            "Accept":"application/json",
            "user-agent":"Weibo For Mac",
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
    func getWeibos(max_id:Int?,completion: @escaping (WeiboRsp) -> Void) {
        let parameters:[String:Any] = [
            "max_id":max_id,
            "Accept":"application/json",
            "user-agent":"Weibo For Mac"
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
    
    
    // MyWeibo
    func getMyWeibo(page:Int,user_id:Int,completion: @escaping (MyWeiboRsp) -> Void) {
        let parameters:[String:Any] = [
            "containerid":"2304132103403282_-_WEIBO_SECOND_PROFILE_WEIBO",
            "Accept":"application/json",
            "user-agent":"Weibo For Mac"
        ]
        AF.request(ApiConfig.baseurl+"/api/container/getIndex",parameters: parameters).validate().responseData { (response) in
            do {
                //let jsdata =  JSON(response.data)
                
                
//                let decoder = JSONDecoder()
//                let rates = try decoder.decode([Spot].self, from: data)
//                let rate = rates.filter { $0.id == "36" }
//                print(rate)
                
                
                //print("4-jsdata",jsdata["data"])
//                let ff  = try jsdata["data"].rawData()
//                let object = try JSONDecoder().decode((MyWeiboRsp).self, from: ff)
                
//                completion(object)
            }catch(let error) {
                print("decode fail:",error)
            }
        }
    }

    
    
}

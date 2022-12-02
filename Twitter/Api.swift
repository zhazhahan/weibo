//
//  ApiRequest.swift
//  TV Demo App
//
//  Created by 韩炸炸 on 2022/11/3.
//

import Alamofire
import SwiftyJSON
import Foundation

enum ApiConfig {
    static let baseurl = "http://121.4.50.150/zapi/public/index.php/api"
}


class Api{

    //
    func getWeibos(page:Int,user_id:Int,completion: @escaping (WeiboRsp) -> Void) {
        let parameters:[String:Any] = ["page":page,"user_id":user_id]
        AF.request(ApiConfig.baseurl+"/user/userweibo",parameters: parameters).validate().responseData { (response) in
            do {
                let jsdata = JSON(response.data)
                let ff  = try jsdata.rawData()
                let object = try JSONDecoder().decode(WeiboRsp.self, from: ff)
                completion(object)
            }catch(let error) {
                print("decode fail:",error)
            }
        }
    }
    
    
    //
    func syncData(user_id:Int,completion: @escaping (Rsp) -> Void) {
        let parameters:[String:Any] = ["user_id":user_id]
        AF.request(ApiConfig.baseurl+"/user/weibo?user_id=2",parameters: parameters).validate().responseData { (response) in
            do {
                let jsdata = JSON(response.data)
                let ff  = try jsdata.rawData()
                let object = try JSONDecoder().decode(Rsp.self, from: ff)
                completion(object)
            }catch(let error) {
                print("decode fail:",error)
            }
        }
    }
}





//
//  ModuleNetworking.swift
//  Alamofire
//
//  Created by 黄磊 on 2018/3/16.
//  网络模块

import Foundation

/// 当前使用的网络模块
#if MODULE_NETWORKING
public let TheNetworking = getTheModule("Networking") as! ModuleNetworking.Type
#else
public let TheNetworking = getTheModule("Networking", DefaultNetworking.self) as! ModuleNetworking.Type
#endif




/// 网络请求协议声明
public protocol ModuleNetworking : ModuleProtocol {
    static func startGet(_ url:String, completion: ActionCompleteBlock?)
    static func startGetText(_ url:String, completion: ActionCompleteBlock?)
    static func startDownload(_ remotePath: String, savePath: String, completion:((URLResponse?, Any?, Error?) -> Void)?)
}


/// 网络请求协议的默认实现
extension ModuleNetworking {

    public static func startGet(_ url: String, completion: ActionCompleteBlock?) {
        
        /// invalidURL
        guard let urlR = URL.init(string: url) else {
            if completion != nil {
                completion!(false, "invalidURL:" + url, nil)
            }
            return
        }

        let task = URLSession.shared.dataTask(with: urlR) { (data, response, error) in

            /// 没有回调
            guard let completion = completion else { return }

            /// 如果有error，网络请求失败，处理完，返回
            if let error = error  {
                completion(false, error.localizedDescription, error as AnyObject)
                return
            }

            /// 成功后，判断data有值没
            guard let data = data else {
                completion(false, "failure", nil)
                return
            }

            /// data转json
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
                completion(false, "failure", nil)
                return
            }

            /// 最后完成回调
            completion(true, "succeed", json as AnyObject)

        }

        task.resume()
    }
    
    public static func startGetText(_ url: String, completion: ActionCompleteBlock?) {
        print("startGetText")
    }
    
    public static func startDownload(_ remotePath: String, savePath: String, completion:((URLResponse?, Any?, Error?) -> Void)?) {
        print("startDownload")
    }

}


// MARK: - DefaultNetworking
/// 默认网络模块
#if !MODULE_NETWORKING
public class DefaultNetworking : ModuleNetworking {
    
    
}
#endif




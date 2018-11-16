//
//  AppConfig.swift
//  Alamofire
//
//  Created by 黄磊 on 2018/3/21.
//

import Foundation

/// 所有配置参数
let g_appConfig : Dictionary<String, Any> = {
    var aAppConfig : Dictionary<String, Any> = [:]
    #if ModuleConfig
    aAppConfig.merge(moduleConfig) { (_, last) in last }
    #endif
    #if UserConfig
    aAppConfig.merge(userConfig) { (_, last) in last }
    #endif
    return aAppConfig
}()

/// 配置参数列表
public struct ConfigKey {
    /// 基础服务器地址
    public static let kBaseHost          = "kBaseHost"
    /// 服务器地址，改地址未设置是默认使用基础服务器地址
    public static let kServerBaseHost    = "kServerBaseHost"
    /// 服务器路径 如:"/apps/LimitChat/LimitChat4/"
    public static let kServerPath        = "kServerPath"
    
    /// App id
    public static let kAppId             = "kAppId"
    
    /// App UUID
    public static let kAppUUID           = "kAppUUID"

}

public class Config {
    
    public class func valueOf(_ key:String) -> Any? {
        return g_appConfig[key]
    }
    
    
    public class func valueOf<T>(_ key:String, _ defVaule:T) -> T {
        return g_appConfig[key] as? T ?? defVaule
    }
}


extension Config {
    public static func append(value: String?, otherValue: String?) -> String? {
        guard let value = value else { return nil }
        guard let otherValue = otherValue else { return nil }
        return value + otherValue
    }
}


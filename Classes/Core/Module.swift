//
//  Module.swift
//  Alamofire
//
//  Created by 黄磊 on 2018/3/22.
//

import Foundation

/// 最常用回调, (BOOL isSucceed, NSString *message, id data)
public typealias ActionCompleteBlock = (Bool, String, Any?) -> Void


/// 模块协议
public protocol ModuleProtocol {
    
}

/// 默认模块类
class DefaultModule: ModuleProtocol {
    
}


/// 获取对于模块使用类
public func getTheModule(_ moduleClass : String, _ defaultClass : AnyClass) -> AnyClass {

    if let aConfigClassString = Config.valueOf(moduleClass) as? String,
       let aClass = NSClassFromString(aConfigClassString) {
        return aClass
    } else {
        let classString = "MJ" + moduleClass + "." + moduleClass
        guard let bClass = NSClassFromString(classString) else { return defaultClass }
        return bClass
    }
}

/// 获取对于模块使用类
public func getTheModule(_ moduleClass : String) -> AnyClass {

    guard let aConfigClassString = Config.valueOf(moduleClass) as? String else { return DefaultModule.self }
    
    guard let aClass = NSClassFromString(aConfigClassString) else { return DefaultModule.self }
    
    return aClass
}


public func getTheModule1<T>(_ moduleClass : String, _ returnClass:T, _ defaultClass : AnyClass) ->  T.Type {
    
    var aClass : AnyClass? = nil
    let aConfigClassString = Config.valueOf(moduleClass)
    if aConfigClassString != nil && type(of: aConfigClassString) == String.self {
        aClass = NSClassFromString(aConfigClassString as! String)
    }

    if aClass == nil {
        let aClassString = "MJ" + moduleClass + "." + moduleClass
        aClass = NSClassFromString(aClassString)
    }

    if aClass == nil {
        return defaultClass as! T.Type
    }
    return aClass! as! T.Type
}

//
//  ModuleWebInterface.swift
//  Alamofire
//
//  Created by 刘鹏i on 2018/11/8.
//

import Foundation

#if MODULE_WEBINTERFACE
public let TheWebInterface = getTheModule("WebInterface") as! ModuleWebInterface.Type
#else
public let TheWebInterface = getTheModule("WebInterface", DefaultWebInterface.self) as! ModuleWebInterface.Type
#endif

// MARK: - ModuleWebInterface
public protocol ModuleWebInterface: ModuleProtocol {
    /// 根据requestId 来取消对应的请求
    static func cancelRequestWith(_ requestId: String)
    
    /// 取消所有的请求
    static func cancelAllRequest()

    static func startRequest(_ action: String, describe: String, completion: ActionCompleteBlock?) -> String

    static func latestAction(for aAction: String) -> String?
    
    /// 重置请求model，一般是在请求头部信息修改是重置
    static func resetRequestMode()
}

// MARK: - DefaultPath
#if !MODULE_WEBINTERFACE
public class DefaultWebInterface: ModuleWebInterface {
    /// 根据requestId 来取消对应的请求
    public static func cancelRequestWith(_ requestId: String) {
        
    }
    
    /// 取消所有的请求
    public static func cancelAllRequest() {
        
    }
    
    public static func startRequest(_ action: String, describe: String, completion: ActionCompleteBlock?) -> String {
        return ""
    }
    
    public static func latestAction(for aAction: String) -> String? {
        return nil
    }
    
    /// 重置请求model，一般是在请求头部信息修改是重置
    public static func resetRequestMode() {
        
    }
}
#endif

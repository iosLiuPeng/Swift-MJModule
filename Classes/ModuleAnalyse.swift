//
//  ModuleAnalyse.swift
//  WebInterface
//
//  Created by Yang Yu on 2018/8/22.
//  Copyright © 2018 Musjoy. All rights reserved.
//  统计模块

import Foundation

#if MODULE_ANALYSE
public let TheAnalyse = getTheModule("Analyse") as! ModuleAnalyse.Type
#else
public let TheAnalyse = getTheModule("Analyse", DefaultAnalyse.self) as! ModuleAnalyse.Type
#endif


/// Analyse的方法声明 
public protocol ModuleAnalyse: ModuleProtocol {
    /// 对应OC中 triggerEventStr
    static func triggerEvent(evenDesc: String, forKey eventId: String)
    
    /// 对用OC中 triggerEvent
    static func triggerEvent(attrs: [String: Any], forKey eventId: String)
    static func triggerBeginPage(_ className: String)
    static func triggerEndPage(_ className: String)
}


/// Analyse的方法默认实现
extension ModuleAnalyse {
    
    public static func triggerEvent(evenDesc: String, forKey eventId: String) {
        LogInfo("triggerEvent evenDesc")
    }
    
    public static func triggerEvent(attrs: [String : Any], forKey eventId: String) {
        LogInfo("triggerEvent attrs")
    }
    
    public static func triggerBeginPage(_ className: String) {
        LogInfo("triggerBeginPage")
    }
    
    public static func triggerEndPage(_ className: String) {
        LogInfo("triggerEndPage")
    }
}


#if !MODULE_ANALYSE
/// 默认Analyse
public class DefaultAnalyse: ModuleAnalyse {

  
}
#endif

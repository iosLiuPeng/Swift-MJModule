//
//  ModuleTime.swift
//  WebInterface
//
//  Created by Yang Yu on 2018/8/22.
//  Copyright © 2018 Musjoy. All rights reserved.
//  时间模块

import Foundation

#if MODULE_TIME
public let TheTime = getTheModule("Time") as! ModuleTime.Type
#else
public let TheTime = getTheModule("Time", DefaultTime.self) as! ModuleTime.Type
#endif


/// Time的一些方法声明
public protocol ModuleTime: ModuleProtocol {
    static func curServerDate() -> Date
    static func curServerDateForServer(_ key: String) -> Date
    static func updateServer(key serverKey : String, serverDate: Date, localDate: Date)
}


/// Time的一些方法默认实现
extension ModuleTime {
    public static func curServerDate() -> Date {
        return Date()
    }
    
    public static func curServerDateForServer(_ key: String) -> Date {
        return Date()
    }
    
    public static func updateServer(key serverKey: String, serverDate: Date, localDate: Date) {
        
    }
}


//MARK:- DefaultTime
/// 默认Time
#if !MODULE_TIME
public class DefaultTime: ModuleTime {
    
}
#endif


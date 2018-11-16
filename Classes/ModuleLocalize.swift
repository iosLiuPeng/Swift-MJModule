//
//  Localize.swift
//  WebInterface
//
//  Created by Yang Yu on 2018/8/20.
//  Copyright © 2018 Musjoy. All rights reserved.
//  国际化模块

import Foundation

/// 当前使用的本地化
#if MODULE_LOCALIZE
public let TheLocalize = getTheModule("Localize") as! ModuleLocalize.Type
#else
public let TheLocalize = getTheModule("Localize", DefaultLocalize.self) as! ModuleLocalize.Type
#endif


/// 本地化协议声明
public protocol ModuleLocalize : ModuleProtocol {
    
    /// 本地化
    ///
    /// - Parameter str: 需要国际化的字段
    /// - Returns: 返回国际化字段
    static func locString(_ str: String) -> String
    
    /// 本地化format
    ///
    /// - Parameters:
    ///   - str: 需要国际化的字段
    ///   - arguments: 需要拼接的元素, 一般是字符串, int, float等类型
    /// - Returns: 返回国际化字段
    static func locString(format str: String, _ arguments: Any...) -> String
}


/// 本地化协议的默认实现
extension ModuleLocalize {
    public static func locString(_ str: String) -> String {
        return NSLocalizedString(str, comment: "")
    }
    
    public static func locString(format str: String, _ arguments: Any...) -> String {
        var str = self.locString(str)
        for argument in arguments {
            if let range = str.range(of: "%@", options: .literal) {
                str.replaceSubrange(range, with: "\(argument)")
            }
        }
        return str
    }
}


/// 扩展String
extension String {
    /// 当前字符串的本地化
    public var locString: String {
        return TheLocalize.locString(self)
    }
}


// MARK: - DefaultLocalize
/// 默认本地化模块
#if !MODULE_LOCALIZE
public class DefaultLocalize : ModuleLocalize {

}
#endif

//
//  ModuleJson.swift
//  MJModule
//
//  Created by 黄磊 on 2018/3/22.
//  Json解析模块

import Foundation

/// 当前使用的Json解析模块
#if MODULE_JSON
public let TheJson = getTheModule("Json") as! ModuleJson.Type
#else
public let TheJson = getTheModule("Json", DefaultJson.self) as! ModuleJson.Type
#endif


/// Json转化时可能抛出异常
///
/// - encoding: 转Data时出错
/// - serialize: 转Json时出错
public enum ModuleJsonError: Error {
    case encoding
    case serialize
}


/// Json协议
public protocol ModuleJson: ModuleProtocol {

    /// 字符串转Json
    ///
    /// - Parameter string: 字符串
    /// - Returns: Json
    /// - Throws: 转Data时可能出错, 转Json时可能出错
    static func json(from string: String) throws -> Any
    
    /// Json转字符串
    ///
    /// - Parameter dict: 字典
    /// - Returns: 字符串
    /// - Throws: 转Data时可能出错, 转Json时可能出错
    static func string(from dict: [String: Any]) throws -> String
}


/// Json默认实现
extension ModuleJson {
    
    public static func json(from string: String) throws -> Any {
        guard let data = string.data(using: .utf8) else { throw ModuleJsonError.encoding }
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { throw ModuleJsonError.serialize }
        return dict
    }
    
    
    public static func string(from dict: [String: Any]) throws -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) else { throw ModuleJsonError.serialize }
        guard let str = String(data: data, encoding: String.Encoding.utf8) else { throw ModuleJsonError.encoding }
        return str
    }
}


#if !MODULE_JSON
/// 默认Json模块
public class DefaultJson : ModuleJson {

}
#endif

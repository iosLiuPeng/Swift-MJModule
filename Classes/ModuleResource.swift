//
//  ModuleFileSource.swift
//  WebInterface
//
//  Created by Yang Yu on 2018/8/21.
//  Copyright © 2018 Musjoy. All rights reserved.
//  FileSource

import Foundation

// MARK: - ModuleResource
#if MODULE_RESOURCE
public let TheResource = getTheModule("Resource") as! ModuleResource.Type
#else
public let TheResource = getTheModule("Resource", DefaultResource.self) as! ModuleResource.Type
#endif

public protocol ModuleResource: ModuleProtocol {
    
    /// 取文件
    /// 模糊搜索可能的扩展名，使用查到的结果中的第一个文件。
    /// 可以取出沙盒、Bundle、Assets.xcassets（只能取Assets中Data Set文件）中的文件
    /// - Parameter fileName: 文件名
    /// - Returns: 文件数据
    static func getData(fileName: String) -> Data?
    
    /// 取文件
    /// 查找指定扩展名的文件
    /// 可以取出沙盒、Bundle、Assets.xcassets（只能取Assets中Data Set文件）中的文件
    /// - Parameter fileName: 文件名
    /// - Returns: 文件数据
    static func getData(fileName: String, extension: String) -> Data?
    
    /// 取文件，并转为对应数据类型
    static func getModel<T>(type: T.Type, fileName: String) -> T? where T : Decodable
    
    /// 取文件，并转为对应数据类型
    static func getModel<T>(type: T.Type, fileName: String, extension: String) -> T? where T : Decodable
    
    
    /// 添加监听文件更新
    ///
    /// - Parameters:
    ///   - files: 文件名集合
    ///   - updated: 文件更新回调处理
    /// - Returns: 监听ID，用于移除此次监听
    static func observeFiles(_ files: [String], completion: @escaping () -> Void) -> String
    
    /// 移除文件更新监听
    ///
    /// - Parameter observeID: 监听ID
    static func removeObserve(_ observeID: String)
}

/// ModuleResource的方法默认实现
extension ModuleResource {
    /// 解码
    static func decode<T>(_ type: T.Type, from data: Data) -> T? where T : Decodable {
        if let model = try? JSONDecoder().decode(type, from: data) {
            return model
        } else if let model = try? PropertyListDecoder().decode(type, from: data) {
            return model
        } else {
            return nil
        }
    }
    
    /// 取文件，并转为对应数据类型
    public static func getModel<T>(type: T.Type, fileName: String) -> T? where T : Decodable {
        guard let data = getData(fileName: fileName) else { return nil }
        return decode(type, from: data)
    }
    
    /// 取文件，并转为对应数据类型
    public static func getModel<T>(type: T.Type, fileName: String, extension: String) -> T? where T : Decodable {
        guard let data = getData(fileName: fileName, extension: `extension`) else { return nil }
        return decode(type, from: data)
    }
}


// MARK: - DefaultResource
#if !MODULE_RESOURCE
public class DefaultResource: ModuleResource {
    /// 取Bundle中文件
    public static func getData(fileName: String) -> Data? {
        return DefaultResource.getData(fileName: fileName, extension: "plist")
    }
    
    /// 取Bundle中文件
    public static func getData(fileName: String, extension: String) -> Data? {
        let name = fileName + "." + `extension`
        guard var url = Bundle.main.resourceURL else { return nil }
        url.appendPathComponent(name)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }

    /// 添加监听文件更新
    ///
    /// - Parameters:
    ///   - files: 文件名集合
    ///   - updated: 文件更新回调处理
    /// - Returns: 监听ID，用于移除此次监听
    public static func observeFiles(_ files: [String], completion: @escaping () -> Void) -> String { return "" }
    
    /// 移除文件更新监听
    ///
    /// - Parameter observeID: 监听ID
    public static func removeObserve(_ observeID: String) {}
}

#endif

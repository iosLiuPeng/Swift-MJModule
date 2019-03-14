//
//  File.swift
//  Alamofire
//
//  Created by 刘鹏i on 2018/10/12.
//

import Foundation

/// 文件夹目录名
public struct Folder {
    /// 沙盒图片保存目录
    public static let image          = Config.valueOf("LOCAL_IMAGE_FOLDER_NAME", "localImage")
    /// 沙盒音频保存目录
    public static let audio          = Config.valueOf("LOCAL_AUDIO_FOLDER_NAME", "localAudio")
    /// 沙盒视频保存目录
    public static let video          = Config.valueOf("LOCAL_VIDEO_FOLDER_NAME", "localVideo")
    /// 沙盒临时保存目录
    public static let temp           = Config.valueOf("LOCAL_TEMP_FOLDER_NAME", "localTemp")
    /// 沙盒配置文件目录
    public static let localConfig    = Config.valueOf("LOCAL_CONFIG_FOLDER_NAME", "localConfig")
    /// Bundle配置文件目录
    public static let bundleConfig   = Config.valueOf("BUNDLE_CONFIG_FOLDER_NAME", "Configs")
}

// MARK: - ModulePath
/*
 其他协议都已有一个对应的实体类，但这个协议暂时没有，它只提供一些简单的功能。
 考虑到以后的扩展性，所以还是决定使用协议的形式来实现功能，而不是用一个单独的类。
 所以这里的FilePath这个名字没有意义，将来如果有提供此功能的类，可以将名字换为此类的名字
 
 这里也可以不使用协议，而是使用ThePath这样一个类来实现。
 但是这样就是一个独立的类了，不太适合放在MJModule中。
 但是因为其功能简单，使用时如果还要单独导这个类就有点麻烦。
 哎，纠结
 */
#if MODULE_PATH
public let ThePath = getTheModule("FilePath") as! ModulePath.Type
#else
public let ThePath = getTheModule("FilePath", DefaultPath.self) as! ModulePath.Type
#endif


public protocol ModulePath: ModuleProtocol {
    /*-----------path: URL?-----------*/
    /// 沙盒图片保存目录
    static func localImageURL() -> URL
    /// 沙盒音频保存目录
    static func localAudioURL() -> URL
    /// 沙盒视频保存目录
    static func localVideoURL() -> URL
    /// 沙盒临时保存目录
    static func localTempURL() -> URL
    /// 沙盒配置文件目录
    static func localConfigURL() -> URL
    
    /// 沙盒文件目录
    ///
    /// - Parameter folderName: 文件夹名。如果不传或传入空字符串，则DEBUG模式下返回document目录，RELEASE模式下返回library目录
    /// - Returns: 沙盒文件目录
    static func localFileURL(folderName: String?) -> URL
    
    /// Bundle配置文件目录
    static func bundleConfigURL() -> URL?
    
    /// Bundle文件目录
    ///
    /// - Parameter folderName: 文件夹名。如果不传或传入空字符串，则返回bundle主目录
    /// - Returns: Bundle文件目录
    static func bundleFileURL(folderName: String?) -> URL?
    
    
    /*----------path: String?----------*/
    /// 沙盒图片保存目录
    static func localImagePath() -> String
    /// 沙盒音频保存目录
    static func localAudioPath() -> String
    /// 沙盒视频保存目录
    static func localVideoPath() -> String
    /// 沙盒临时保存目录
    static func localTempPath() -> String
    /// 沙盒配置文件目录
    static func localConfigPath() -> String
    
    /// 沙盒文件目录
    ///
    /// - Parameter folderName: 文件夹名。如果不传或传入空字符串，则DEBUG模式下返回document目录，RELEASE模式下返回library目录
    /// - Returns: 沙盒文件目录
    static func localFilePath(folderName: String?) -> String
    
    /// Bundle配置文件目录
    static func bundleConfigPath() -> String?
    
    /// Bundle文件目录
    ///
    /// - Parameter folderName: 文件夹名。如果不传或传入空字符串，则返回bundle主目录
    /// - Returns: Bundle文件目录
    static func bundleFilePath(folderName: String?) -> String?
}

/// ModulePath的默认实现
extension ModulePath {
    
}


// MARK: - DefaultPath
#if !MODULE_PATH
public class DefaultPath: ModulePath {
    /*-----------path: URL?-----------*/
    /// 沙盒图片保存目录
    public static func localImageURL() -> URL {
        return localFileURL(folderName: Folder.image)
    }
    
    /// 沙盒音频保存目录
    public static func localAudioURL() -> URL {
        return localFileURL(folderName: Folder.audio)
    }
    
    /// 沙盒视频保存目录
    public static func localVideoURL() -> URL {
        return localFileURL(folderName: Folder.video)
    }
    
    /// 沙盒临时保存目录
    public static func localTempURL() -> URL {
        return localFileURL(folderName: Folder.temp)
    }
    
    /// 沙盒配置文件目录
    public static func localConfigURL() -> URL {
        return localFileURL(folderName: Folder.localConfig)
    }
    
    /// 沙盒文件目录
    ///
    /// - Parameter folderName: 文件夹名。如果不传或传入空字符串，则DEBUG模式下返回document目录，RELEASE模式下返回library目录
    /// - Returns: 沙盒文件目录
    public static func localFileURL(folderName: String?) -> URL {
        let manager = FileManager.default
        #if DEBUG
        let urls = manager.urls(for: .documentDirectory, in: .userDomainMask)
        #else
        let urls = manager.urls(for: .libraryDirectory, in: .userDomainMask)
        #endif
        
        // 沙盒目录
        var url = urls.first!
        
        // 拼接目录
        if let folderName = folderName {
            url.appendPathComponent(folderName, isDirectory: true)
        }
        
        if manager.fileExists(atPath: url.path) == false {
            // 如果文件夹不存在，则创建
            do {
                try manager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                LogError("create Directory failed: '\(url.path)'")
            }
        }
        
        return url
    }
    
    /// Bundle配置文件目录
    public static func bundleConfigURL() -> URL? {
        return bundleFileURL(folderName: Folder.bundleConfig)
    }
    
    /// Bundle文件目录
    ///
    /// - Parameter folderName: 文件夹名。如果不传或传入空字符串，则返回bundle主目录
    /// - Returns: Bundle文件目录
    public static func bundleFileURL(folderName: String?) -> URL? {
        guard var url = Bundle.main.resourceURL else { return nil }
        
        if let folderName = folderName {
            url.appendPathComponent(folderName)
        }
        return url
    }
    
    /// 沙盒图片保存目录
    public static func localImagePath() -> String {
        return localImageURL().path
    }
    /// 沙盒音频保存目录
    public static func localAudioPath() -> String {
        return localAudioURL().path
    }
    /// 沙盒视频保存目录
    public static func localVideoPath() -> String {
        return localVideoURL().path
    }
    /// 沙盒临时保存目录
    public static func localTempPath() -> String {
        return localTempURL().path
    }
    /// 沙盒配置文件目录
    public static func localConfigPath() -> String {
        return localConfigURL().path
    }
    /// 沙盒文件目录
    ///
    /// - Parameter folderName: 文件夹名。如果不传或传入空字符串，则DEBUG模式下返回document目录，RELEASE模式下返回library目录
    /// - Returns: 沙盒文件目录
    public static func localFilePath(folderName: String?) -> String {
        return localFileURL(folderName: folderName).path
    }
    
    /// Bundle配置文件目录
    public static func bundleConfigPath() -> String? {
        return bundleConfigURL()?.path
    }
    /// Bundle文件目录
    ///
    /// - Parameter folderName: 文件夹名。如果不传或传入空字符串，则返回bundle主目录
    /// - Returns: Bundle文件目录
    public static func bundleFilePath(folderName: String?) -> String? {
        return bundleFileURL(folderName: folderName)?.path
    }
}
#endif

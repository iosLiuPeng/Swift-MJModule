//
//  Log.swift
//  Alamofire
//
//  Created by 黄磊 on 2018/5/30.
//
import Foundation

// MARK: - 扩展

extension ConfigKey {
    /// 日志
    public struct Log {
        
        // 日志屏蔽
        /// 屏蔽跟踪日志
        public static let blockTrace    = "LogBlockTrace"
        /// 屏蔽信息日志
        public static let blockInfo     = "LogBlockInfo"
        /// 屏蔽Debug日志
        public static let blockDebug    = "LogBlockDebug"
        /// 屏蔽警告日志
        public static let blockWarning  = "LogBlockWarning"
        /// 屏蔽错误日志
        public static let blockError    = "LogBlockError"
        
        
        // 日志格式
        /// 日志 不包含时间
        public static let withoutTime   = "LogWithoutTime"
        /// 日志 不包含行数
        public static let withoutLine   = "LogWithoutLine"
        /// 日志 不包含方法名
        public static let withoutMethod = "LogWithoutMethod"
        
        
        /// 打印到控制台
        public static let toConsole     = "LogToConsole"
        /// 写入到文件
        public static let writeToFile   = "LogWriteToFile"
    }
}


// MARK: - 静态变量

// 日志颜色，暂时没有使用
public let g_logColorTrace : UIColor    = Config.valueOf("LogColorTrace", UIColor.lightGray)
public let g_logColorInfo : UIColor     = Config.valueOf("LogColorInfo", UIColor.black)
public let g_logColorDebug : UIColor    = Config.valueOf("LogColorDebug", UIColor.lightGray)
public let g_logColorWarning : UIColor  = Config.valueOf("LogColorWarning", UIColor.yellow)
public let g_logColorError : UIColor    = Config.valueOf("LogColorError", UIColor.red)

/// 日志日期格式
let s_dateFormat : DateFormatter = {
    let dateFormat : DateFormatter = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS|Z"
    return dateFormat
}()

// 日志屏蔽
let s_logBlockTrace     = isLogBlockFor(ConfigKey.Log.blockTrace, false)
let s_logBlockInfo      = isLogBlockFor(ConfigKey.Log.blockInfo, false)
let s_logBlockDebug     = isLogBlockFor(ConfigKey.Log.blockDebug, true)
let s_logBlockWarning   = isLogBlockFor(ConfigKey.Log.blockWarning, false)
let s_logBlockError     = isLogBlockFor(ConfigKey.Log.blockError, false)

// 日志格式
let s_logWithoutTime    = Config.valueOf(ConfigKey.Log.withoutTime, false)
let s_logWithoutLine    = Config.valueOf(ConfigKey.Log.withoutLine, false)
let s_logWithoutMethod  = Config.valueOf(ConfigKey.Log.withoutMethod, false)

// 打印到控制台
let s_logToConsole      = Config.valueOf(ConfigKey.Log.toConsole, false)
// 写入日志到文件
let s_logWriteToFile    = Config.valueOf(ConfigKey.Log.writeToFile, false)

// MARK: - 公共方法

/// 跟踪流程时使用
public func LogTrace(_ message:Any..., color:UIColor = g_logColorTrace, _ file: String = #file, _ line: Int = #line, _ method: String = #function) {
    s_logBlockTrace ? nil : LogFormat(" ➡️Trace➡️ ", message, color:color, file, line, method)
}

public func LogInfo(_ message:Any..., color:UIColor = g_logColorInfo, _ file: String = #file, _ line: Int = #line, _ method: String = #function) {
    s_logBlockInfo ? nil : LogFormat(" 👉Info👉  ", message, color:color, file, line, method)
}

public func LogDebug(_ message:Any..., color:UIColor = g_logColorDebug, _ file: String = #file, _ line: Int = #line, _ method: String = #function) {
    s_logBlockDebug ? nil : LogFormat(" 🔍Debug🔍 ", message, color:color, file, line, method)
}

public func LogWarning(_ message:Any..., color:UIColor = g_logColorWarning, _ file: String = #file, _ line: Int = #line, _ method: String = #function) {
    s_logBlockWarning ? nil : LogFormat("⚠️Warning⚠️", message, color:color, file, line, method)
}


public func LogError(_ message:Any..., color:UIColor = g_logColorError, _ file: String = #file, _ line: Int = #line, _ method: String = #function) {
    s_logBlockError ? nil : LogFormat(" ‼️Error‼️ ", message, color:color, file, line, method)
}


// MARK: - 私有方法

/// 格式化log
func LogFormat(_ type:String, _ messages:[Any], color:UIColor, _ file: String = #file, _ line: Int = #line, _ method: String = #function) {
#if DEBUG
    let message = messages.map {"\($0)"}.joined(separator: " ")
    let location = (file as NSString).lastPathComponent + (s_logWithoutLine ? "" : String(format:"(%4d)", line)) + (s_logWithoutMethod ? "" : ("." + method));
    print(s_logWithoutTime ? "" : s_dateFormat.string(from: Date()), "[\(type)]", location, "↔️" , message)
#else
    
    #if ForTest
    // 测试版log即打到控制台，也打到日志
    let message = messages.map {"\($0)"}.joined(separator: " ")
    let location = (file as NSString).lastPathComponent + (s_logWithoutLine ? "" : String(format:"(%4d)", line)) + (s_logWithoutMethod ? "" : ("." + method));
    print(s_logWithoutTime ? "" : s_dateFormat.string(from: Date()), "[\(type)]", location, "↔️" , message)
    // 打印到日志
    LogToFile(type, messages, color: color, file, line, method)
    #else
    if s_logToConsole {
        let message = messages.map {"\($0)"}.joined(separator: " ")
        let location = (file as NSString).lastPathComponent + (s_logWithoutLine ? "" : String(format:"(%4d)", line)) + (s_logWithoutMethod ? "" : ("." + method));
        print(s_logWithoutTime ? "" : s_dateFormat.string(from: Date()), "[\(type)]", location, "↔️" , message)
    }
    if s_logWriteToFile {
        // 发布的非测试产品，如果开启了该功能，也可以写入到文件
        LogToFile(type, messages, color: color, file, line, method)
    }
    
    #endif
    
#endif
}

// 记录到文件，后期开发
func LogToFile(_ type:String, _ messages:[Any], color:UIColor, _ file: String = #file, _ line: Int = #line, _ method: String = #function) {
    
}

/// 判断是否屏蔽Log
func isLogBlockFor(_ blockType : String, _ defaut : Bool) -> Bool {
    let isBlock = Config.valueOf(blockType, defaut);
    if isBlock != defaut {
        if isBlock {
            print("\n‼️⚠️⚠️‼️ [ \(blockType) ] is enable🚫")
        } else {
            print("\n‼️⚠️⚠️‼️ [ \(blockType) ] is disable✅")
        }
    }
    return isBlock;
}



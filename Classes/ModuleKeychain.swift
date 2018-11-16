//
//  ModuleKeychain.swift
//  WebInterface
//
//  Created by Yang Yu on 2018/8/21.
//  Copyright © 2018 Musjoy. All rights reserved.
//  Keychain存取

import Foundation

#if MODULE_KEYCHAIN
public let TheKeychain = getTheModule("Keychain") as! ModuleKeychain.Type
#else
public let TheKeychain = getTheModule("Keychain", DefaultKeychain.self) as! ModuleKeychain.Type
#endif


/// Keychain的方法声明
public protocol ModuleKeychain: ModuleProtocol {
    static func set(_ value: Any?, forKey key: String)
    static func value(forKey key: String) -> Any?
    static func setDefaultShared(_ value: Any?, forKey key: String)
    static func defaultSharedValue(forKey key: String) -> Any?
}


/// Keychain的方法默认实现
extension ModuleKeychain {
    public static func set(_ value: Any?, forKey key: String)  {
        var dicQuery = [kSecClass: kSecClassGenericPassword,
                        kSecReturnAttributes: kCFBooleanTrue,
                        kSecAttrService: (Bundle.main.bundleIdentifier ?? "") + ".DefaultService",
                        kSecAttrAccount: key] as [CFString : Any]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(dicQuery as CFDictionary, &result)
        if status == noErr {
            let dicUpdate = [kSecAttrGeneric: value]
            SecItemUpdate(dicQuery as CFDictionary, dicUpdate as CFDictionary)
        } else {
            if value == nil { return }
            dicQuery[kSecAttrGeneric] = value
            SecItemAdd(dicQuery as CFDictionary, &result)
        }
        
}
    
    public static func value(forKey key: String) -> Any? {
        
        let dicQuery = [kSecClass: kSecClassGenericPassword,
                        kSecReturnAttributes: kCFBooleanTrue,
                        kSecAttrService: (Bundle.main.bundleIdentifier ?? "") + ".DefaultService",
                        kSecAttrAccount: key] as [CFString : Any]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(dicQuery as CFDictionary, &result)
        
        if status == noErr {
            guard let items = result as? [CFString: Any] else { return nil }
            return items[kSecAttrGeneric]
        }
        
        return nil
    }
    
    public static func setDefaultShared(_ value: Any?, forKey key: String) {
        set(value, forKey: key)
    }
    
    public static func defaultSharedValue(forKey key: String) -> Any? {
        return value(forKey: key)
    }
}


//MARK:- DefaultKeychain
/// 默认Keychain
#if !DefaultKeychain
public class DefaultKeychain: ModuleKeychain {

}
#endif

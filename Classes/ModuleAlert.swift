//
//  ModuleAlert.swift
//  MJModule
//
//  Created by Yang Yu on 2018/9/3.
//  弹框

import Foundation

#if MODULE_ALERT
public let TheAlert = getTheModule("Alert") as! ModuleAlert.Type
#else
public let TheAlert = getTheModule("Alert", DefaultAlert.self) as! ModuleAlert.Type
#endif


/// 弹框回调
public typealias ModuleAlertCallback = (Int) -> Void

/// Alert的方法声明
public protocol ModuleAlert: ModuleProtocol {
    static func alert(title: String?, message: String)
    static func alert(info: [String: Any], callback: ModuleAlertCallback?)
    static func alert(title: String?, message: String?, cancel: String?, confirm: String?, destroy: String?, callback: ModuleAlertCallback?)
}


/// Alert的方法默认实现
extension ModuleAlert {

    public static func alert(title: String?, message: String) {
        self.alert(title: title, message: message, cancel: nil, confirm: nil, destroy: nil, callback: nil)
    }
    
    public static func alert(info: [String: Any], callback: ModuleAlertCallback?) {
        self.alert(title: info["title"] as? String, message: info["message"] as? String, cancel: info["cancel"] as? String, confirm: info["confirm"] as? String, destroy: info["destroy"] as? String, callback: callback)
    }

    public static func alert(title: String?, message: String?, cancel: String?, confirm: String?, destroy: String?, callback: ModuleAlertCallback?) {
        
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if (cancel != nil) && (cancel!.count > 0) {
            let action = UIAlertAction(title: cancel!, style: .cancel) { (_) in
                (callback != nil) ? callback!(0) : nil
            }
            alertVc.addAction(action)
        }
        
        if (confirm != nil) && (confirm!.count > 0) {
            let action = UIAlertAction(title: confirm!, style: .default) { (_) in
                (callback != nil) ? callback!(1) : nil
            }
            alertVc.addAction(action)
        }
        
        if (destroy != nil) && (destroy!.count > 0) {
            let action = UIAlertAction(title: destroy!, style: .default) { (_) in
                (callback != nil) ? callback!(-1) : nil
            }
            alertVc.addAction(action)
        }
        
        TheBaseViewController.topViewController.present(alertVc, animated: true, completion: nil)
    }
}


#if !MODULE_ALERT
/// 默认Alert
public class DefaultAlert: ModuleAlert {
    
    
}
#endif

//
//  ModuleAlert.swift
//  MJModule
//
//  Created by 刘鹏i on 2018/11/30.
//

import Foundation

// MARK: - ModuleAlert
#if MODULE_ALERT
public let TheAlert = getTheModule("Alert") as! ModuleAlert.Type
#else
public let TheAlert = getTheModule("Alert", DefaultAlert.self) as! ModuleAlert.Type
#endif

/// 按钮类别
public enum AlertInfoKey: String, CaseIterable {
    case title
    case message
    case cancel
    case confirm
    case destructive
}

// MARK: - ModuleAlert
public protocol ModuleAlert: ModuleProtocol {
    /// Alert点击回调
    typealias AlertCompletion = (Int) -> Void

    
    /// 显示一个弹框，带有确定按钮
    static func showAlert(title: String?, message: String?, completion: AlertCompletion?)
    
    /// 显示一个弹框，自己处理按钮本地化
    static func showAlert(title: String?, message: String?, cancel: String?, confirm: String?, completion: AlertCompletion?)
    
    /// 显示一个弹框，支持多个按钮，自己处理按钮本地化
    static func showAlert(info: [AlertInfoKey: String], otherButtons: [String]?, completion: AlertCompletion?)
    
    /// 显示一个弹框，有返回值，可自定义，可用于addTextField
    static func showCustomAlert(info: [AlertInfoKey: String], otherButtons: [String]?, completion: AlertCompletion?) -> UIAlertController
    
    
    /// 显示一个ActionSheet，带有确定按钮
    static func showActionSheet(title: String?, message: String?, onView: UIView, completion: AlertCompletion?)
    
    /// 显示一个ActionSheet，自己处理按钮本地化
    static func showActionSheet(title: String?, message: String?, cancel: String?, confirm: String?, onView: UIView, completion: AlertCompletion?)
    
    /// 显示一个ActionSheet，支持多个按钮，自己处理按钮本地化
    static func showActionSheet(info: [AlertInfoKey: String], otherButtons: [String]?, onView: UIView, completion: AlertCompletion?)
    
    
    /// 解析弹框用到的原始信息（配置文件数据）
    static func parsingOriginalInfo(_ dict: [String: Any]) -> (info: [AlertInfoKey: String], otherButtons: [String]?)
}

extension ModuleAlert {
    /// 解析弹框用到的原始信息（配置文件数据）
    public static func parsingOriginalInfo(_ dict: [String: Any]) -> (info: [AlertInfoKey: String], otherButtons: [String]?) {
        
        var info = [AlertInfoKey: String]()
        
        // 解析标准key
        for key in AlertInfoKey.allCases {
            // 直接取
            if let value = dict[key.rawValue] as? String {
                if value.count > 0 {
                    info[key] = value
                }
            }
            
            // 通过key间接取
            if let locKey = dict[key.rawValue + "Key"] as? String {
                let value = locKey.locString
                if value != locKey {
                    info[key] = value
                }
            }
        }
        
        // 解析otherButtons
        let otherButtons = dict["btns"] as? [String]
        
        return (info, otherButtons)
    }
}


// MARK: - DefaultAlert
#if !MODULE_ALERT
public class DefaultAlert: ModuleAlert {

    /// 显示一个弹框，带有确定按钮
    public static func showAlert(title: String?, message: String?, completion: AlertCompletion?) {
        var info = [AlertInfoKey: String]()
        info[.title] = title
        info[.message] = message
        
        _ = show(.alert, info: info, otherButtons: nil, onView: nil, completion: completion)
    }
    
    /// 显示一个弹框，自己处理按钮本地化
    public static func showAlert(title: String?, message: String?, cancel: String?, confirm: String?, completion: AlertCompletion?) {
        var info = [AlertInfoKey: String]()
        info[.title] = title
        info[.message] = message
        info[.cancel] = cancel
        info[.confirm] = confirm
        
        _ = show(.alert, info: info, otherButtons: nil, onView: nil, completion: completion)
    }
    
    /// 显示一个弹框，支持多个按钮，自己处理按钮本地化
    public static func showAlert(info: [AlertInfoKey: String], otherButtons: [String]?, completion: AlertCompletion?) {
        _ = show(.alert, info: info, otherButtons: otherButtons, onView: nil, completion: completion)
    }
    
    /// 显示一个弹框，有返回值，可自定义，可用于addTextField
    public static func showCustomAlert(info: [AlertInfoKey: String], otherButtons: [String]?, completion: AlertCompletion?) -> UIAlertController {
        return show(.alert, info: info, otherButtons: otherButtons, onView: nil, completion: completion)
    }
    

    /// 显示一个ActionSheet，带有确定按钮
    public static func showActionSheet(title: String?, message: String?, onView: UIView, completion: AlertCompletion?) {
        var info = [AlertInfoKey: String]()
        info[.title] = title
        info[.message] = message
        
        _ = show(.actionSheet, info: info, otherButtons: nil, onView: onView, completion: completion)
    }
    
    /// 显示一个ActionSheet，自己处理按钮本地化
    public static func showActionSheet(title: String?, message: String?, cancel: String?, confirm: String?, onView: UIView, completion: AlertCompletion?) {
        var info = [AlertInfoKey: String]()
        info[.title] = title
        info[.message] = message
        info[.cancel] = cancel
        info[.confirm] = confirm
        
        _ = show(.actionSheet, info: info, otherButtons: nil, onView: onView, completion: completion)
    }
    
    /// 显示一个ActionSheet，支持多个按钮，自己处理按钮本地化
    public static func showActionSheet(info: [AlertInfoKey: String], otherButtons: [String]?, onView: UIView, completion: AlertCompletion?) {
        _ = show(.actionSheet, info: info, otherButtons: otherButtons, onView: onView, completion: completion)
    }
    
    
    /// 弹框
    static func show(_ style: UIAlertController.Style, info: [AlertInfoKey: String], otherButtons: [String]?, onView: UIView?, completion: AlertCompletion?) -> UIAlertController {
        let title = info[.title]
        let message = info[.message]
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        var offset = 1;/// .default样式按钮的序号
        
        // 取消
        if let cancel = info[.cancel] {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { (AlertAction) in
                completion?(0)
            }))
        }
        
        // 确定
        if let confirm = info[.confirm] {
            alert.addAction(UIAlertAction(title: confirm, style: .default, handler: { (AlertAction) in
                completion?(1)
            }))
            offset += 1
        }
        
        // 取消、确定按钮必须有一个（除了无按钮样式）
        if alert.actions.count == 0 {
            alert.addAction(UIAlertAction(title: "Ok".locString, style: .default, handler: { (AlertAction) in
                completion?(1)
            }))
            offset += 1
        }
        
        // 破坏性操作
        if let destructive = info[.destructive] {
            alert.addAction(UIAlertAction(title: destructive, style: .destructive, handler: { (AlertAction) in
                completion?(-1)
            }))
        }
        
        // 其他按钮
        if let otherButtons = otherButtons {
            for title in otherButtons {
                let index = offset
                alert.addAction(UIAlertAction(title: title, style: .default, handler: { (AlertAction) in
                    completion?(index)
                }))
                
                offset += 1
            }
        }
        
        // ipad上 .actionSheet样式要特殊处理
        if UIDevice.current.userInterfaceIdiom == .pad && style == .actionSheet {
            // 必须要有一个按钮，不然点其他地方弹框消失了，window没消失
            if  alert.actions.count == 0 {
                alert.addAction(UIAlertAction(title: "Cancel".locString , style: .cancel, handler: { (AlertAction) in
                    completion?(0)
                }))
            }
            
            // ipad上，必须要设置依靠的视图
            if let onView = onView {
                alert.popoverPresentationController?.sourceView = onView
                alert.popoverPresentationController?.sourceRect = onView.bounds
            }
        }
        
        // 顶层控制器弹出
        if let topVC = topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
        
        return alert
    }
    
    /// 顶部控制器
    static func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.delegate?.window, let aWindow = window, let rootVC = aWindow.rootViewController else { return nil }
        
        var top = rootVC
        while top.presentedViewController != nil {
            top = top.presentedViewController!
        }
        
        return top
    }
}
#endif

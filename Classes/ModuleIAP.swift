//
//  ModuleIAP.swift
//  Pods
//
//  Created by Yang Yu on 2018/9/12.
//

import Foundation

/// 当前使用的Json解析模块
#if MODULE_IAP
public let TheIAP = getTheModule("IAPKit") as! ModuleIAP.Type
#else
public let TheIAP = getTheModule("IAPKit", DefaultIAP.self) as! ModuleIAP.Type
#endif


public protocol ModuleIAP: ModuleProtocol {
    /// 监听该产品购买，购买成功即执行，一次性的,调用完之后不会再调用。注意：主要用于非消耗性、订阅，消耗性不建议使用
    /// 监听该产品列表购买，列表中只要有一个购买，就会调用回调，之后该block回被移除不再使用
    ///
    /// - Parameters:
    ///   - productId: 商品ID, 多个
    ///   - completion: 完成回调
    static func observeProduct(with productId: String..., completion: ActionCompleteBlock)
}

extension ModuleIAP {
    public static func observeProduct(with productId: String..., completion: ActionCompleteBlock) {
        
    }
    
    /// 是否正在处理购买
    public static var isProcessing: Bool {
        return false
    }
}



#if !MODULE_IAP
public class DefaultIAP: ModuleIAP {

}
#endif

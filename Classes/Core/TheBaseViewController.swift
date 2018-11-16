//
//  TheBaseViewController.swift
//  MJModule
//
//  Created by 黄磊 on 2018/3/22.
//  BaseViewControoler 声明

import UIKit


#if MODULE_BASEVIEWCONTROLLER
public typealias TheBaseViewController = MJBaseViewController
#else
public typealias TheBaseViewController = UIViewController
#endif


public protocol ModuleController: ModuleProtocol {
    
   
}

extension ModuleController {
    public func config(with data: Any, attachment: Any? = nil) {
        
    }
}

extension ModuleController {
    public static var topViewController: UIViewController {
        var topVC: UIViewController?
        var navVC = (UIApplication.shared.keyWindow?.rootViewController)!
        while navVC.presentedViewController != nil {
            navVC = navVC.presentedViewController!
        }
        if navVC is UINavigationController {
            topVC = (navVC as! UINavigationController).topViewController
        }else {
            topVC = navVC
        }
        while (topVC is UINavigationController) || (topVC is UITabBarController) {
            if topVC is UITabBarController {
                let tabBarVC = topVC as! UITabBarController
                var selectedIndex = tabBarVC.selectedIndex
                if selectedIndex <= 0 || selectedIndex >= (tabBarVC.viewControllers?.count)! {
                    selectedIndex = 0
                }
                topVC = tabBarVC.viewControllers?[selectedIndex]
            }else {
                let navVC = topVC as! UINavigationController
                topVC = navVC.topViewController
            }
        }
        return topVC!
    }
}


#if !MODULE_BASEVIEWCONTROLLER
extension TheBaseViewController: ModuleController {

}
#endif

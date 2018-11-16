//
//  TheBaseViewController.swift
//  MJModule
//
//  Created by 黄磊 on 2018/3/22.
//

import UIKit

protocol MJBaseViewControllerProtocol {
    
}

extension MJBaseViewControllerProtocol {
    
}

#if BaseViewController
public typealias TheBaseViewController = BaseViewController
#else
public typealias TheBaseViewController = UIViewController
#endif


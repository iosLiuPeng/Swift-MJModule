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

public protocol ModuleAlert: ModuleProtocol {
    
}

extension ModuleAlert {
    
}

// MARK: - DefaultAlert
#if !MODULE_ALERT
public class DefaultAlert: ModuleAlert {
    
    
}
#endif

//
//  ModuleDevice.swift
//  WebInterface
//
//  Created by Yang Yu on 2018/8/21.
//  Copyright © 2018 Musjoy. All rights reserved.
//  获取设备一些信息 Device

import Foundation

#if MODULE_DEVICE
public let TheDevice = getTheModule("Device") as! ModuleDevice.Type
#else
public let TheDevice = getTheModule("Device", DefaultDevice.self) as! ModuleDevice.Type
#endif


///// 后台更新的设备列表key
//let FILE_NAME_DEVICE_MAP = "device_map"


/// Device的一些方法声明
public protocol ModuleDevice: ModuleProtocol {


}


/// Device的一些方法默认实现
extension ModuleDevice {

    /// 获取设备唯一标识
    public static var deviceUUID: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }

    /// 获取设备版本
    public static var deviceVersion: String {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0,  count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }

    /// 获取设备版本
    public static var deviceVersionName: String {

        let device = self.deviceVersion

        #if os(iOS)
        #endif

        /// From https://github.com/squarefrog/UIDeviceIdentifier
        var dicDevices = [
            "iPhone1,1"   : "iPhone 1G",
            "iPhone1,2"   : "iPhone 3G",
            "iPhone2,1"   : "iPhone 3GS",
            "iPhone3,1"   : "iPhone 4 (GSM)",
            "iPhone3,2"   : "iPhone 4 (GSM Rev A)",
            "iPhone3,3"   : "iPhone 4 (CDMA)",
            "iPhone4,1"   : "iPhone 4S",
            "iPhone5,1"   : "iPhone 5 (GSM)",
            "iPhone5,2"   : "iPhone 5 (GSM+CDMA)",
            "iPhone5,3"   : "iPhone 5C (GSM)",
            "iPhone5,4"   : "iPhone 5C (GSM+CDMA)",
            "iPhone6,1"   : "iPhone 5S (GSM)",
            "iPhone6,2"   : "iPhone 5S (GSM+CDMA)",
            "iPhone7,1"   : "iPhone 6 Plus",
            "iPhone7,2"   : "iPhone 6",
            "iPhone8,1"   : "iPhone 6s",
            "iPhone8,2"   : "iPhone 6s Plus",
            "iPhone8,4"   : "iPhone SE",
            "iPhone9,1"   : "iPhone 7",
            "iPhone9,2"   : "iPhone 7 Plus",
            "iPhone9,3"   : "iPhone 7",
            "iPhone9,4"   : "iPhone 7 Plus",

            "iPhone10,1"  : "iPhone 8",
            "iPhone10,2"  : "iPhone 8 Plus",
            "iPhone10,3"  : "iPhone X",
            "iPhone10,4"  : "iPhone 8",
            "iPhone10,5"  : "iPhone 8 Plus",
            "iPhone10,6"  : "iPhone X",

            "iPhone11,4"  : "iPhone XS Max",
            "iPhone11,2"  : "iPhone XS",
            "iPhone11,8"  : "iPhone XR",
            
            "iPod1,1"     : "iPod Touch 1G",
            "iPod2,1"     : "iPod Touch 2G",
            "iPod3,1"     : "iPod Touch 3G",
            "iPod4,1"     : "iPod Touch 4G",
            "iPod5,1"     : "iPod Touch 5G",
            "iPod7,1"     : "iPod Touch 6G",

            "iPad1,1"     : "iPad 1",
            "iPad2,1"     : "iPad 2 (WiFi)",
            "iPad2,2"     : "iPad 2 (GSM)",
            "iPad2,3"     : "iPad 2 (CDMA)",
            "iPad2,4"     : "iPad 2",
            "iPad2,5"     : "iPad Mini (WiFi)",
            "iPad2,6"     : "iPad Mini (GSM)",
            "iPad2,7"     : "iPad Mini (GSM+CDMA)",
            "iPad3,1"     : "iPad 3 (WiFi)",
            "iPad3,2"     : "iPad 3 (GSM+CDMA)",
            "iPad3,3"     : "iPad 3 (GSM)",
            "iPad3,4"     : "iPad 4 (WiFi)",
            "iPad3,5"     : "iPad 4 (GSM)",
            "iPad3,6"     : "iPad 4 (GSM+CDMA)",
            "iPad4,1"     : "iPad Air (WiFi)",
            "iPad4,2"     : "iPad Air (WiFi/Cellular)",
            "iPad4,3"     : "iPad Air (China)",
            "iPad4,4"     : "iPad Mini Retina (WiFi)",
            "iPad4,5"     : "iPad Mini Retina (WiFi/Cellular)",
            "iPad4,6"     : "iPad Mini Retina (China)",
            "iPad4,7"     : "iPad Mini 3 (WiFi)",
            "iPad4,8"     : "iPad Mini 3 (WiFi/Cellular)",
            "iPad5,1"     : "iPad Mini 4 (WiFi)",
            "iPad5,2"     : "iPad Mini 4 (WiFi/Cellular)",
            "iPad5,3"     : "iPad Air 2 (WiFi)",
            "iPad5,4"     : "iPad Air 2 (WiFi/Cellular)",
            "iPad6,3"     : "iPad Pro 9.7-inch (WiFi)",
            "iPad6,4"     : "iPad Pro 9.7-inch (WiFi/Cellular)",
            "iPad6,7"     : "iPad Pro 12.9-inch (WiFi)",
            "iPad6,8"     : "iPad Pro 12.9-inch (WiFi/Cellular)",

            "iPad6,11"    : "iPad 5 (WiFi)",
            "iPad6,12"    : "iPad 5 (WiFi/Cellular)",

            "i386"        : "Simulator",
            "x86_64"      : "Simulator",

            "AppleTV5,3"  : "Apple TV 4G",
            ]


        //        if let dicAddition = TheResource.getData(FILE_NAME_DEVICE_MAP) as? [String: String],
        //            dicAddition.keys.count > 0 {
        //            dicDevices.merge(dicAddition) { (_, new) -> String in
        //                return new
        //            }
        //        }

        return dicDevices[device] ?? ""
    }

    /// 获取系统版本
    public static var sysVersion: String {
        return "iOS " + UIDevice.current.systemVersion
    }
}



#if !MODULE_DEVICE
/// 默认Device
public class DefaultDevice: ModuleDevice {
    

}
#endif

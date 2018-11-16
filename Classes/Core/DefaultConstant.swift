//
//  DefaultConstant.swift
//  Alamofire
//
//  Created by 黄磊 on 2018/3/15.
//

import Foundation


// MARK: - 服务器
/// 基础服务器地址
public let kBaseHost                = Config.valueOf(ConfigKey.kBaseHost) as? String
/// 服务器地址
public let kServerBaseHost          = Config.valueOf(ConfigKey.kServerBaseHost) as? String


public let kServerPath              = Config.valueOf(ConfigKey.kServerPath) as? String

public let kBaseUrl                 = Config.append(value: kBaseHost, otherValue: kServerPath)
public let kServerUrl               = Config.append(value: kServerBaseHost, otherValue: kServerPath)
public let kServerAction            = Config.append(value: kServerUrl, otherValue: "action/")


// MARK: - App信息
/// 公开版本号。eg：1.0
public let kClientVersion           = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
/// 内部版本号。eg：1.0.1
public let kClientBuildVersion      = Bundle.main.infoDictionary!["CFBundleVersion"]
/// 内部版本号。eg：1.0.1
public let kSystemVersion           = Float(UIDevice.current.systemVersion)! * 10000

/// App Id in App Store
public let kAppId                   = Config.valueOf("kAppId", "")
/// 线上App信息查看链接
public let kAppLookUpUrl            = "https://itunes.apple.com/lookup?id=" + kAppId
/// 线上App下载链接
public let kAppDownload             = "https://itunes.apple.com/app/id" + kAppId
/// 线上App评论链接（iOS11 以下）
public let kAppOldComment           = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=" + kAppId + "&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
/// 线上App评论链接
public let kAppComment              = (kSystemVersion<110000) ? kAppOldComment:kAppDownload
/// App包名
public let kAppBundleId             = Bundle.main.infoDictionary!["CFBundleIdentifier"] as? String
/// App UUID
public let kAppUUID                 = Config.valueOf(ConfigKey.kAppUUID) as? String

// MARK: - 下面两个信息横竖屏时可能存在问题
/// 全屏宽度
public let kScreenWitdh             = UIScreen.main.bounds.width
/// 全屏高度
public let kScreenHeight            = UIScreen.main.bounds.width


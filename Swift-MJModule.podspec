Pod::Spec.new do |s|
    s.name            = 'MJModule'
    s.version         = "0.1.0"
    s.swift_version   = '4.2'
    s.summary         = "This is a module management center in swift"
    s.homepage        = "https://github.com/iosLiuPeng/Swift-MJModule"
    s.license         = { :type => 'MIT', :file => 'LICENSE' }
    s.author          = { 'iosLiuPeng' => '392009255@qq.com' }
    s.module_name     = 'Swift-MJModule'
    s.source          = { :git => "https://github.com/iosLiuPeng/Swift-MJModule.git", :tag => "v-#{s.version}" }
    s.ios.deployment_target = '8.0'
  
    s.default_subspec = 'Core'

    s.user_target_xcconfig = {
        'OTHER_SWIFT_FLAGS' => '-DMODULE'
    }
  
    s.preserve_path = 'ModuleConfig.swift'
    
    # 加了这句, (pod 'MJModule')就是把所有的子模块都包含里面
  # s.source_files = 'Swift-MJModule/Classes/**/*'
  
  # 核心模块
  s.subspec 'Core' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/Core/*.swift'
  end
  
  s.subspec 'Networking' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleNetworking.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'WebInterface' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleWebInterface.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'Json' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleJson.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'Localize' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleLocalize.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'Resource' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleResource.swift'
      ss.dependency 'Swift-MJModule/Core'
  end

  s.subspec 'FilePath' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModulePath.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'Keychain' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleKeychain.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'Device' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleDevice.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'Analyse' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleAnalyse.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'Time' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleTime.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'Alert' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleAlert.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
  
  s.subspec 'IAP' do |ss|
      ss.source_files = 'Swift-MJModule/Classes/ModuleIAP.swift'
      ss.dependency 'Swift-MJModule/Core'
  end
end

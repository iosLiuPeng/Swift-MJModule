Pod::Spec.new do |s|
    s.name            = 'MJModule'
    s.version         = '0.1.0'
    s.swift_version   = '4.2'
    s.summary         = 'This is a module management center in swift'
    s.homepage        = 'https://github.com/iosLiuPeng/Swift-MJModule'
    s.license         = { :type => 'MIT', :file => 'LICENSE' }
    s.author          = { 'iosLiuPeng' => '392009255@qq.com' }
    s.source          = { :git => 'https://github.com/iosLiuPeng/Swift-MJModule.git', :tag => "v-#{s.version}" }
    s.ios.deployment_target = '8.0'
  
    s.default_subspec = 'Core'

    s.user_target_xcconfig = {
        'OTHER_SWIFT_FLAGS' => '-DMODULE'
    }
  
    s.preserve_path = 'ModuleConfig.swift'
    
  # 加了这句, (pod 'MJModule')就是把所有的子模块都包含里面
#  s.source_files = 'Classes/**/*'

  # 核心模块
  s.subspec 'Core' do |ss|
      ss.source_files = 'Classes/Core/*.swift'
  end

  s.subspec 'Networking' do |ss|
      ss.source_files = 'Classes/ModuleNetworking.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'WebInterface' do |ss|
      ss.source_files = 'Classes/ModuleWebInterface.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'Json' do |ss|
      ss.source_files = 'Classes/ModuleJson.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'Localize' do |ss|
      ss.source_files = 'Classes/ModuleLocalize.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'Resource' do |ss|
      ss.source_files = 'Classes/ModuleResource.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'FilePath' do |ss|
      ss.source_files = 'Classes/ModulePath.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'Keychain' do |ss|
      ss.source_files = 'Classes/ModuleKeychain.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'Device' do |ss|
      ss.source_files = 'Classes/ModuleDevice.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'Analyse' do |ss|
      ss.source_files = 'Classes/ModuleAnalyse.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'Time' do |ss|
      ss.source_files = 'Classes/ModuleTime.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'Alert' do |ss|
      ss.source_files = 'Classes/ModuleAlert.swift'
      ss.dependency 'MJModule/Core'
  end

  s.subspec 'IAP' do |ss|
      ss.source_files = 'Classes/ModuleIAP.swift'
      ss.dependency 'MJModule/Core'
  end
end

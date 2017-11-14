#
#  Be sure to run `pod spec lint VideoEffect.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "VideoEffect"
  s.version      = "0.0.2"
  s.summary      = "StarMaker private Libraries"

  s.homepage     = "https://phabricator.ushow.media/source/client-library/starmaker-VideoEffect"
  
  s.license       = 'zlib'
  
  s.author             = { "xianti.xiong" => "xianti.xiong@ushow.media" }
  
  s.platform     = :ios
  s.platform     = :ios, "9.0"

  s.source    = { :git => 'https://phabricator.ushow.media/source/client-library/starmaker-VideoEffect.git', :tag => "#{s.version}" }

  # s.source_files  = 'VideoEffect/**/*.{h,m,c,cpp,hpp,frag,vert,glsl}','VideoEffect/3rdparty/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
  s.source_files  = 'VideoEffect/*.{h,cpp}'

  s.exclude_files = 'VideoEffect/*.{mk}'
  # s.public_header_files = 'VideoEffect/**/*.h'

  # s.libraries = 'z', 'c++', 'iconv'
  
  s.requires_arc = true

  s.subspec '3rdparty' do |tp|
      tp.source_files  = '3rdparty/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
      # tp.public_header_files = '3rdparty/*.h'

      tp.subspec 'libpng' do |lp|
        lp.source_files  = 'libpng/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
        # lp.public_header_files = 'libpng/*.h'
      end
  end
  s.xcconfig = {
      # 'USER_HEADER_SEARCH_PATHS' => '$(inherited) ${PODS_ROOT}/'
     # 'USER_HEADER_SEARCH_PATHS' => '"${PROJECT_DIR}/.."/**' 
     'USER_HEADER_SEARCH_PATHS' => '"${PROJECT_DIR}/.."'
    }
end

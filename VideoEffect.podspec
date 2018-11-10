#
#  Be sure to run `pod spec lint VideoEffect.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  
  s.name         = "VideoEffect"
  s.version      = "0.1.0"
  s.license      = 'MIT'
  s.summary      = "A delightful iOS framework"
  s.homepage     = "https://github.com/xionggithub/VideoEffect"
  s.author       = { "xiongxianti" => "1273040577@qq.com" }
  s.source   = { :git => 'https://github.com/xionggithub/VideoEffect.git', :tag => "#{s.version}"}
  s.requires_arc = true

  #s.source_files  = 'VideoEffect/*.{h,cpp}'
  s.source_files  = 'VideoEffect/*.{h,cpp,mm}'
  s.public_header_files = 'VideoEffect/VideoEffectProcessFilter.h'

  s.ios.deployment_target = '7.0'
#   s.dependency "GPUImage",'0.1.7'
  s.dependency 'GPUImage', git: 'https://phabricator.ushow.media/source/starmaker-GPUImage.git', :commit => '3b670b787d9ff951ad1db3ea5fd32bb5677d5b38'
  s.subspec '3rdparty' do |tp|
      tp.source_files  = 'VideoEffect/3rdparty/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       tp.public_header_files = 'VideoEffect/3rdparty/*.{h}'
      tp.subspec 'libpng' do |libpng|
        libpng.source_files  = 'VideoEffect/3rdparty/libpng/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#         libpng.public_header_files = 'VideoEffect/3rdparty/libpng/*.{h}'
      end
  end
  s.subspec 'common' do |common|
      common.source_files  = 'VideoEffect/common/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       common.public_header_files = 'VideoEffect/common/*.{h}'
  end
  s.subspec 'decoder' do |decoder|
      decoder.source_files  = 'VideoEffect/decoder/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       decoder.public_header_files = 'VideoEffect/decoder/*.{h}'
  end
  s.subspec 'editmodel' do |editmodel|
      editmodel.source_files  = 'VideoEffect/editmodel/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       editmodel.public_header_files = 'VideoEffect/editmodel/*.{h}'
      editmodel.subspec 'blur_scene' do |blur_scene|
        blur_scene.source_files  = 'VideoEffect/editmodel/blur_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#         blur_scene.public_header_files = 'VideoEffect/editmodel/blur_scene/*.{h}'
      end
    
      editmodel.subspec 'selective_blur_scene' do |selective_blur_scene|
        selective_blur_scene.source_files  = 'VideoEffect/editmodel/selective_blur_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#         selective_blur_scene.public_header_files = 'VideoEffect/editmodel/selective_blur_scene/*.{h}'
      end
    
     editmodel.subspec 'text_scene' do |text_scene|
        text_scene.source_files  = 'VideoEffect/editmodel/text_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#         text_scene.public_header_files = 'VideoEffect/editmodel/text_scene/*.{h}'
      end
  end
  s.subspec 'platform_dependent' do |platform_dependent|
      platform_dependent.source_files  = 'VideoEffect/platform_dependent/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       platform_dependent.public_header_files = 'VideoEffect/platform_dependent/*.{h}'
  end
  
  s.subspec 'videoeffect' do |videoeffect|
      videoeffect.source_files  = 'VideoEffect/videoeffect/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       videoeffect.public_header_files = 'VideoEffect/videoeffect/*.{h}'
      videoeffect.subspec 'blur_scene' do |blur_scene|
        blur_scene.source_files  = 'VideoEffect/videoeffect/blur_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#         blur_scene.public_header_files = 'VideoEffect/videoeffect/blur_scene/*.{h}'
        blur_scene.subspec 'shader' do |shader|
          shader.source_files  = 'VideoEffect/videoeffect/blur_scene/shader/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#           shader.public_header_files = 'VideoEffect/videoeffect/blur_scene/shader/*.{h}'
        end
      end
    
      videoeffect.subspec 'image_effect' do |image_effect|
         image_effect.source_files  = 'VideoEffect/videoeffect/image_effect/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#          image_effect.public_header_files = 'VideoEffect/videoeffect/image_effect/*.{h}'
         image_effect.subspec 'beautify' do |beautify|
           beautify.source_files  = 'VideoEffect/videoeffect/image_effect/beautify/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#            beautify.public_header_files = 'VideoEffect/videoeffect/image_effect/beautify/*.{h}'
         end
        
         image_effect.subspec 'beautify_face' do |beautify_face|
           beautify_face.source_files  = 'VideoEffect/videoeffect/image_effect/beautify_face/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#            beautify_face.public_header_files = 'VideoEffect/videoeffect/image_effect/beautify_face/*.{h}'
         end
        
         image_effect.subspec 'highpass' do |highpass|
           highpass.source_files  = 'VideoEffect/videoeffect/image_effect/highpass/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#            highpass.public_header_files = 'VideoEffect/videoeffect/image_effect/highpass/*.{h}'
         end
        
         image_effect.subspec 'thin' do |thin|
           thin.source_files  = 'VideoEffect/videoeffect/image_effect/thin/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#            thin.public_header_files = 'VideoEffect/videoeffect/image_effect/thin/*.{h}'
         end
        
         image_effect.subspec 'water_mask' do |water_mask|
           water_mask.source_files  = 'VideoEffect/videoeffect/image_effect/water_mask/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#            water_mask.public_header_files = 'VideoEffect/videoeffect/image_effect/water_mask/*.{h}'
         end
        
         image_effect.subspec 'whitening' do |whitening|
           whitening.source_files  = 'VideoEffect/videoeffect/image_effect/whitening/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#            whitening.public_header_files = 'VideoEffect/videoeffect/image_effect/whitening/*.{h}'
           whitening.subspec 'shader' do |shader|
            shader.source_files  = 'VideoEffect/videoeffect/image_effect/whitening/shader/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#             shader.public_header_files = 'VideoEffect/videoeffect/image_effect/whitening/shader/*.{h}'
           end
         end
       end
       videoeffect.subspec 'png_sequence' do |png_sequence|
          png_sequence.source_files  = 'VideoEffect/videoeffect/png_sequence/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#           png_sequence.public_header_files = 'VideoEffect/videoeffect/png_sequence/*.{h}'
       end
    
       videoeffect.subspec 'saturation_scene' do |saturation_scene|
        saturation_scene.source_files  = 'VideoEffect/videoeffect/saturation_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#         saturation_scene.public_header_files = 'VideoEffect/videoeffect/saturation_scene/*.{h}'
       end
    end
    s.subspec 'videoeffect_avc' do |videoeffect_avc|
      videoeffect_avc.source_files  = 'VideoEffect/videoeffect_avc/*.{h,m,c,cpp,hpp,frag,vert,glsl,acv}'
#       videoeffect_avc.public_header_files = 'VideoEffect/videoeffect_avc/*.{h}'
  end
  s.xcconfig = {'USER_HEADER_SEARCH_PATHS' => '$(inherited) ${PODS_ROOT}/VideoEffect/VideoEffect'}
end

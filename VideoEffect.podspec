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
  s.summary      = "A delightful iOS video framework"

  s.homepage     = "https://github.com/xionggithub/VideoEffect.git"
  
  s.license       = 'MIT'
 
  s.author             = { "xiongxianti" => "1273040577@qq.com" }

  s.platform     = :ios, "9.0"

  s.source    = { :git => 'https://phabricator.ushow.media/source/client-library/starmaker-VideoEffect.git', :tag => "#{s.version}" }

  # s.source_files  = 'VideoEffect/**/*.{h,m,c,cpp,hpp,frag,vert,glsl}','VideoEffect/3rdparty/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
  s.source_files  = 'VideoEffect/*.{h,cpp}'

  s.exclude_files = 'VideoEffect/*.{mk}'

  # s.libraries = 'z', 'c++', 'iconv'
  
  s.requires_arc = true

  s.subspec '3rdparty' do |3rdparty|
      tp.source_files  = 'VideoEffect/3rdparty/*.{h,m,c,cpp,hpp,frag,vert,glsl}'

      tp.subspec 'libpng' do |libpng|
        libpng.source_files  = 'VideoEffect/3rdparty/libpng/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
      end
  end
#   s.subspec 'common' do |common|
#       common.source_files  = 'VideoEffect/common/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#   end
#   s.subspec 'decoder' do |decoder|
#       decoder.source_files  = 'VideoEffect/decoder/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#   end
#   s.subspec 'editmodel' do |editmodel|
#       editmodel.source_files  = 'VideoEffect/editmodel/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
      
#       ss.subspec 'blur_scene' do |blur_scene|
#         blur_scene.source_files  = 'VideoEffect/editmodel/blur_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       end
    
#       ss.subspec 'selective_blur_scene' do |selective_blur_scene|
#         selective_blur_scene.source_files  = 'VideoEffect/editmodel/selective_blur_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       end
    
#      ss.subspec 'text_scene' do |text_scene|
#         text_scene.source_files  = 'VideoEffect/editmodel/text_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       end
#   end
#   s.subspec 'platform_dependent' do |platform_dependent|
#       platform_dependent.source_files  = 'VideoEffect/platform_dependent/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#   end
  
#   s.subspec 'videoeffect' do |videoeffect|
#       videoeffect.source_files  = 'VideoEffect/videoeffect/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#       videoeffect.subspec 'blur_scene' do |bs|
#         bs.source_files  = 'VideoEffect/videoeffect/blur_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#         bs.subspec 'shader' do |shader|
#           shader.source_files  = 'VideoEffect/videoeffect/blur_scen/shader/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#         end
#       end
    
#        videoeffect.subspec 'image_effect' do |image_effect|
#          image_effect.source_files  = 'VideoEffect/videoeffect/image_effect/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#          image_effect.subspec 'beautify' do |beautify|
#            beautify.source_files  = 'VideoEffect/videoeffect/image_effect/beautify/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#          end
        
#          image_effect.subspec 'beautify_face' do |beautify_face|
#            beautify_face.source_files  = 'VideoEffect/videoeffect/image_effect/beautify_face/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#          end
        
#          image_effect.subspec 'highpass' do |highpass|
#            highpass.source_files  = 'VideoEffect/videoeffect/image_effect/highpass/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#          end
        
#          image_effect.subspec 'thin' do |thin|
#            thin.source_files  = 'VideoEffect/videoeffect/image_effect/thin/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#          end
        
#          image_effect.subspec 'water_mask' do |water_mask|
#            water_mask.source_files  = 'VideoEffect/videoeffect/image_effect/water_mask/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#          end
        
#          image_effect.subspec 'whitening' do |whitening|
#            whitening.source_files  = 'VideoEffect/videoeffect/image_effect/whitening/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#            whitening.subspec 'shader' do |shader|
#             shader.source_files  = 'VideoEffect/videoeffect/image_effect/whitening/shader/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#            end
#          end
#        videoeffect.subspec 'png_sequence' do |png_sequence|
#         png_sequence.source_files  = 'VideoEffect/videoeffect/png_sequence/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#        end
#        videoeffect.subspec 'saturation_scene' do |saturation_scene|
#         saturation_scene.source_files  = 'VideoEffect/videoeffect/saturation_scene/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#        end
#     end
#     s.subspec 'videoeffect_avc' do |videoeffect_avc|
#       videoeffect_avc.source_files  = 'VideoEffect/videoeffect_avc/*.{h,m,c,cpp,hpp,frag,vert,glsl}'
#   end
end

#import <GPUImage/GPUImage.h>

typedef NS_ENUM(NSUInteger, VideoEffectFilterType) {
    VideoEffectFilterTypeCool,
    VideoEffectFilterTypeThinFace,
    VideoEffectFilterTypeNone,
    VideoEffectFilterTypeOrigin,
    VideoEffectFilterTypeWhitening,
    VideoEffectFilterTypeVINTAGE,//复古
    VideoEffectFilterTypeGinghamq,
    VideoEffectFilterTypeCrema
};
@interface VideoEffectProcessFilter : GPUImageFilter
@property (nonatomic, assign) BOOL enableBeauty;

#pragma mark - Utility
+ (void)checkGLError;

- (void)initializeFilterWithType:(VideoEffectFilterType)type;

@end

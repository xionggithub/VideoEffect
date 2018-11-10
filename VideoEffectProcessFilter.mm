#import "VideoEffectProcessFilter.h"
#import "video_effect_processor.h"
#import "opengl_video_frame.h"
#import "video_effect_params.h"
#import "video_effect_def.h"
#define PREVIEW_FILTER_SEQUENCE_IN          0
#define PREVIEW_FILTER_SEQUENCE_OUT         10 * 60 * 60 * 1000000

@interface VideoEffectProcessFilter()
@property (nonatomic) VideoEffectProcessor *processor;
@property (nonatomic) OpenglVideoFrame *inputVideoFrame;
@property (nonatomic) OpenglVideoFrame *outputVideoFrame;
@property (nonatomic) GLuint outputTexId;
@property (nonatomic) GLuint mFBO;
@property (nonatomic) BOOL isFilterChanged;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) VideoEffectFilterType filterType;
@end


@implementation VideoEffectProcessFilter
- (instancetype)init {
    self = [super init];
    if (self) {
        dispatch_sync([GPUImageContext sharedContextQueue], ^{
            self->_width = 480;
            self->_height = 480;
            self->_enableBeauty = YES;
            self->_isFilterChanged = YES;
            self->_outputTexId = -1;
            self->_filterType = VideoEffectFilterTypeNone;
            self->_processor = new VideoEffectProcessor();
            self->_processor->init();
            glGenFramebuffers(1, &self->_mFBO);
        });
    }
    return self;
}

- (void)dealloc {
    if (_mFBO) {
        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        glDeleteFramebuffers(1, &_mFBO);
    }
    
    _processor->dealloc();
    delete _processor;
    _processor = NULL;
    
    delete _inputVideoFrame;
    _inputVideoFrame = NULL;
    
    delete _outputVideoFrame;
    _outputVideoFrame = NULL;
}

- (void)initializeFilterWithType:(VideoEffectFilterType)type
{
    _filterType = type;
    _isFilterChanged = YES;
}

- (BOOL)switchFilterType
{
    self.processor->removeAllFilters();
    bool ret = true;
    int filterId = -1;
    if (_filterType == VideoEffectFilterTypeCool) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sm_cool" ofType:@"acv"];
        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        unsigned char*  _mACVBuffer = NULL;
        if (myData) {
            _mACVBuffer = new unsigned char[myData.length];
            memcpy(_mACVBuffer, (unsigned char*)[myData bytes], myData.length);
        }
        filterId = [self addFilterWithBuffer:_mACVBuffer bufferSize:int(myData.length)];
    }else if(VideoEffectFilterTypeVINTAGE == _filterType){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sm_vintage" ofType:@"acv"];
        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        unsigned char*  _mACVBuffer = NULL;
        if (myData) {
            _mACVBuffer = new unsigned char[myData.length];
            memcpy(_mACVBuffer, (unsigned char*)[myData bytes], myData.length);
        }
        filterId = [self addFilterWithBuffer:_mACVBuffer bufferSize:int(myData.length)];
    }else if(VideoEffectFilterTypeGinghamq == _filterType){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sm_gingham" ofType:@"acv"];
        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        unsigned char*  _mACVBuffer = NULL;
        if (myData) {
            _mACVBuffer = new unsigned char[myData.length];
            memcpy(_mACVBuffer, (unsigned char*)[myData bytes], myData.length);
        }
        filterId = [self addFilterWithBuffer:_mACVBuffer bufferSize:int(myData.length)];
    }else if(VideoEffectFilterTypeCrema == _filterType){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sm_crema" ofType:@"acv"];
        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        unsigned char*  _mACVBuffer = NULL;
        if (myData) {
            _mACVBuffer = new unsigned char[myData.length];
            memcpy(_mACVBuffer, (unsigned char*)[myData bytes], myData.length);
        }
        filterId = [self addFilterWithBuffer:_mACVBuffer bufferSize:int(myData.length)];
    }else {
        filterId = [self addFilterWithBuffer:NULL bufferSize:0];
    }
    if(filterId >= 0){
        ret = self.processor->invokeFilterOnReady(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId);
    }
    return ret;
}
-(int)addFilterWithBuffer:(byte*)mACVBuffer bufferSize:(int)mACVBufferSize
{
    int filterId = -1;
    switch (_filterType) {
        case VideoEffectFilterTypeCool:
        {
            filterId = self.processor->addFilter(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, PREVIEW_FILTER_SEQUENCE_IN, PREVIEW_FILTER_SEQUENCE_OUT, BEAUTIFY_FACE_COOL_FILTER_NAME);
            if (!_enableBeauty) {
                //如果关闭美颜的话就修改 对应的参数
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:1.0 softLightProgress:0.15 hueAngle:1.0 sharpness:0.5 satuRatio:0.15f];
            }else{
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:0.8 softLightProgress:0.25 hueAngle:0.6 sharpness:0.5 satuRatio:0.25f];
            }
            [self setToneCurveFilterValue:filterId buffer:mACVBuffer bufferSize:mACVBufferSize];
            [self setFilterZoomRatioValue:filterId];
        }
            break;
        case VideoEffectFilterTypeThinFace:
        {
            filterId = self.processor->addFilter(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, PREVIEW_FILTER_SEQUENCE_IN, PREVIEW_FILTER_SEQUENCE_OUT, THIN_BEAUTIFY_FACE_FILTER_NAME);
            if (!_enableBeauty) {
                //如果关闭美颜的话就修改 对应的参数
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:1.0 softLightProgress:0.15 hueAngle:1.0 sharpness:0.5 satuRatio:0.15f];
            }else{
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:0.8 softLightProgress:0.25 hueAngle:0.6 sharpness:0.5 satuRatio:0.25f];
            }
            ParamVal vFlipFlagValue;
            vFlipFlagValue.u.boolVal = true;
            self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, THIN_EFFECT_VFLIP_FLAG, vFlipFlagValue);
            [self setFilterZoomRatioValue:filterId];
        }
            break;
        case VideoEffectFilterTypeOrigin:
        {
            filterId = self.processor->addFilter(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, PREVIEW_FILTER_SEQUENCE_IN, PREVIEW_FILTER_SEQUENCE_OUT, BEAUTIFY_FACE_FILTER_NAME);
            if (!_enableBeauty) {
                //如果关闭美颜的话就修改 对应的参数
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:1.0 softLightProgress:0.15 hueAngle:1.0 sharpness:0.5 satuRatio:0.15f];
            }else{
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:0.8 softLightProgress:0.25 hueAngle:0.6 sharpness:0.5 satuRatio:0.25f];
            }
            [self setFilterZoomRatioValue:filterId];
        }
            break;
        case VideoEffectFilterTypeWhitening:
            filterId = self.processor->addFilter(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, PREVIEW_FILTER_SEQUENCE_IN, PREVIEW_FILTER_SEQUENCE_OUT, BEAUTIFY_FACE_FILTER_NAME);
            if (!_enableBeauty) {
                //如果关闭美颜的话就修改 对应的参数
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:1.0 softLightProgress:0.15 hueAngle:1.0 sharpness:0.5 satuRatio:0.15f];
            }else{
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:0.4 softLightProgress:0.38 hueAngle:0.4 sharpness:0.5 satuRatio:0.3f];
            }
            [self setFilterZoomRatioValue:filterId];
            break;
        case VideoEffectFilterTypeNone:
        {
            filterId = self.processor->addFilter(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, PREVIEW_FILTER_SEQUENCE_IN, PREVIEW_FILTER_SEQUENCE_OUT, BEAUTIFY_FACE_FILTER_NAME);
            if (!_enableBeauty) {
                //如果关闭美颜的话就修改 对应的参数
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:1.0 softLightProgress:0.15 hueAngle:1.0 sharpness:0.5 satuRatio:0.15f];
                ParamVal smoothSkinEffectEnableValue;
                smoothSkinEffectEnableValue.u.boolVal = false;
                self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, SMOOTH_SKIN_EFFECT_PARAM_ENABLED, smoothSkinEffectEnableValue);
            }else{
                
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:0.8 softLightProgress:0.25 hueAngle:0.6 sharpness:0.5 satuRatio:0.25f];
                ParamVal smoothSkinEffectEnableValue;
                smoothSkinEffectEnableValue.u.boolVal = true;
                self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, SMOOTH_SKIN_EFFECT_PARAM_ENABLED, smoothSkinEffectEnableValue);
            }
            [self setFilterZoomRatioValue:filterId];
        }
            break;
        case VideoEffectFilterTypeVINTAGE:
        case VideoEffectFilterTypeGinghamq:
        case VideoEffectFilterTypeCrema:
        {
            filterId = self.processor->addFilter(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, PREVIEW_FILTER_SEQUENCE_IN, PREVIEW_FILTER_SEQUENCE_OUT, BEAUTIFY_FACE_COOL_FILTER_NAME);
            if (!_enableBeauty) {
                //如果关闭美颜的话就修改 对应的参数
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:1.0 softLightProgress:0.15 hueAngle:1.0 sharpness:0.5 satuRatio:0.15f];
            }else{
                [self setBeautifyFaceFilterValue:filterId maskCurveProgress:0.8 softLightProgress:0.25 hueAngle:0.6 sharpness:0.5 satuRatio:0.25f];
            }
            [self setToneCurveFilterValue:filterId buffer:mACVBuffer bufferSize:mACVBufferSize];
            [self setFilterZoomRatioValue:filterId];
        }
            break;
    }
    return filterId;

}
- (void)renderToTextureWithVertices:(const GLfloat *)vertices
                 textureCoordinates:(const GLfloat *)textureCoordinates
{
//    [super renderToTextureWithVertices:vertices textureCoordinates:textureCoordinates];
//    return;
    GL_CHECK_ERROR("KTVMVFilter at the beginning of renderToTexture");
    if (self.preventRendering) {
        [firstInputFramebuffer unlock];
        return;
    }
    if(_isFilterChanged) {
        [self switchFilterType];
        _isFilterChanged = NO;
    }
    CGFloat width = firstInputFramebuffer.size.width;
    CGFloat height = firstInputFramebuffer.size.height;
    
    if (!outputFramebuffer) {
        outputFramebuffer = [[GPUImageContext sharedFramebufferCache] fetchFramebufferForSize:[self sizeOfFBO]
                                                                               textureOptions:self.outputTextureOptions
                                                                                  onlyTexture:NO];
        self.outputTexId = [outputFramebuffer texture];
    }
    
    [outputFramebuffer lock];
    ImagePosition imagePosition;
    imagePosition.x = 0;
    imagePosition.y = 0;
    imagePosition.width = width;
    imagePosition.height = height;
    
    if (!self.inputVideoFrame) {
        self.inputVideoFrame = new OpenglVideoFrame([firstInputFramebuffer texture], imagePosition);
    } else {
        self.inputVideoFrame->init([firstInputFramebuffer texture], imagePosition);
    }
    
    if (!self.outputVideoFrame) {
        self.outputVideoFrame = new OpenglVideoFrame(self.outputTexId, imagePosition);
    } else {
        self.outputVideoFrame->init(self.outputTexId, imagePosition);
    }
    
    glBindFramebuffer(GL_FRAMEBUFFER, self.mFBO);
    GL_CHECK_ERROR("KTVMVFilter before process");
    self.processor->process(self.inputVideoFrame, 0.0f, self.outputVideoFrame);
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    GL_CHECK_ERROR("KTVMVFilter after process");
    
    [firstInputFramebuffer unlock];
    GL_CHECK_ERROR("KTVMVFilter after firstInputFBO");
}

#pragma mark - Effect

- (void) setBeautifyFaceFilterValue:(int)filterId maskCurveProgress:(float)maskCurveProgress softLightProgress:(float)softLightProgress hueAngle:(float) hueAngle sharpness:(float) sharpness satuRatio:(float)satuRatio;
{
    ParamVal textureWidthValue;
    textureWidthValue.u.intVal = _width;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, WHITENING_FILTER_TEXTURE_WIDTH, textureWidthValue);
    ParamVal textureHeightValue;
    textureHeightValue.u.intVal = _height;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, WHITENING_FILTER_TEXTURE_HEIGHT, textureHeightValue);
    ParamVal smoothSkinEffectParamChangedValue;
    smoothSkinEffectParamChangedValue.u.boolVal = true;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, SMOOTH_SKIN_EFFECT_PARAM_CHANGED, smoothSkinEffectParamChangedValue);
    ParamVal maskCurveProgressValue;
    maskCurveProgressValue.u.fltVal = maskCurveProgress;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, MASK_CURVE_PROGRESS, maskCurveProgressValue);
    ParamVal softLightProgressValue;
    softLightProgressValue.u.fltVal = softLightProgress;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, SOFT_LIGHT_PROGRESS, softLightProgressValue);
    ParamVal satuRatioValue;
    satuRatioValue.u.fltVal = satuRatio;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, SATU_RATIO, satuRatioValue);
    ParamVal hueAngleChangedValue;
    hueAngleChangedValue.u.boolVal = true;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, HUE_EFFECT_HUE_ANGLE_CHANGED, hueAngleChangedValue);
    ParamVal hueAngleValue;
    hueAngleValue.u.fltVal = hueAngle;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, HUE_EFFECT_HUE_ANGLE, hueAngleValue);
    ParamVal sharpnessValue;
    sharpnessValue.u.fltVal = sharpness;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, SHARPEN_EFFECT_SHARPNESS, sharpnessValue);
    ParamVal groupEffectWidthValue;
    groupEffectWidthValue.u.intVal = _width;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, IMAGE_EFFECT_GROUP_TEXTURE_WIDTH, groupEffectWidthValue);
    ParamVal groupEffectHeightValue;
    groupEffectHeightValue.u.intVal = _height;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, IMAGE_EFFECT_GROUP_TEXTURE_HEIGHT, groupEffectHeightValue);
    
    ParamVal smoothSkinEffectEnableValue;
    if (_enableBeauty) {
        smoothSkinEffectEnableValue.u.boolVal = true;
    }else{
        smoothSkinEffectEnableValue.u.boolVal = false;
    }
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, SMOOTH_SKIN_EFFECT_PARAM_ENABLED, smoothSkinEffectEnableValue);
}


-(void)setToneCurveFilterValue:(int)filterId buffer:(byte*)mACVBuffer bufferSize:(int)mACVBufferSize
{
    ParamVal changeFlagValue;
    changeFlagValue.u.boolVal = true;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, TONE_CURVE_FILTER_ACV_BUFFER_CHANGED, changeFlagValue);
    ParamVal acvBufferValue;
    acvBufferValue.u.arbData = mACVBuffer;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, TONE_CURVE_FILTER_ACV_BUFFER, acvBufferValue);
    ParamVal acvBufferSizeValue;
    acvBufferSizeValue.u.intVal = mACVBufferSize;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, TONE_CURVE_FILTER_ACV_BUFFER_SIZE, acvBufferSizeValue);
}

-(void)setFilterZoomRatioValue:(int)filterId
{
    ParamVal zoomRatioValue;
    zoomRatioValue.u.fltVal = 0.95;
    self.processor->setFilterParamValue(EFFECT_PROCESSOR_VIDEO_TRACK_INDEX, filterId, IMAGE_EFFECT_ZOOM_VIEW_RATIO, zoomRatioValue);
}

#pragma mark - Utility
+ (void)checkGLError {
    GLenum glError = glGetError();
    if (glError != GL_NO_ERROR) {
        NSLog(@"GL error: 0x%x", glError);
    }
}

@end

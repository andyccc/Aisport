//
//  TRAIPlayVideoViewController.m
//  Aisport
//
//  Created by YANS on 2020/10/19.
//

#import "TRAIPlayVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CGSizeExtension.h"
#import "Aisport-Swift.h"

#import "CalibrateBodyView.h"
#import "EnergyGetView.h"
#import "SelVideoSlider.h"
#import "ActionVigourView.h"
#import "StopTrainView.h"

#import "ASTrainReportController.h"
#import "BaseNavigationController.h"

#import "PlaySoundService.h"
#import "SoundPlayCenter.h"



@interface TRAIPlayVideoViewController () <CameraFeedManagerDelegate>

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/** 时间监听器 */
@property (nonatomic, strong) id timeObserve;

@property (nonatomic, strong) OverlayView *overlayView;
@property (nonatomic, strong) PreviewView *previewView;

@property (nonatomic, assign) CGFloat minimumScore;
@property (nonatomic, assign) CGRect overlayViewFrame;
@property (nonatomic, assign) CGRect previewViewFrame;

@property (nonatomic, strong) CalibrateBodyView *calibrateBodyView;
@property (nonatomic, strong) EnergyGetView *energyGetView;
/** 进度滑杆 */
@property (nonatomic, strong) SelVideoSlider *videoSlider;

@property (nonatomic, strong) ModelDataHandler *modelDataHandler;
@property (nonatomic, strong) CameraFeedManager *cameraCapture;
@property (nonatomic, strong) ActionVigourView *actionVigourView;
@property (nonatomic, strong) UIImageView *bubbleImageView;
@property (nonatomic, strong) UILabel     *messageLabel;
@property (nonatomic, strong) StopTrainView *stopTrainView;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) long long timeCount;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) BOOL isLeave;
@property (nonatomic, assign) BOOL isPlayStop;

@property (nonatomic, assign) BOOL isPlayGood;

@property (nonatomic, assign) long actionGoodCount;



@property (nonatomic, assign) int cpuCount; // cpu核心，默认2
@property (nonatomic, assign) int detectType; // 0 cpu 1 gpu 2 npu
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, strong) ActionDetectorSelector *actionDetectorSelector;


@end

@implementation TRAIPlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController.navigationBar setHidden:YES];

    self.isLeave = YES;
    self.isPlayStop = NO;
    _actionGoodCount = 0;
    self.isPlayGood = YES;
    
    // 设置参数默认值
    self.minimumScore = 0.5;
    self.cpuCount = 2;
    self.detectType = 0;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *mediaUrl = [NSString stringWithFormat:@"%@.mp4",StringForId(_courseModel.name)];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, mediaUrl];
//    NSString *urlPath = [[NSBundle mainBundle] pathForResource:StringForId(_courseModel.name) ofType:@"mp4"];

//    NSURL *videoURL = [NSURL fileURLWithPath:fullPath];
    NSURL *url = [NSURL fileURLWithPath:fullPath];
    
//    NSURL *url = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];
    self.player = [AVPlayer playerWithURL:url];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.playerLayer];
    [self.player seekToTime:CMTimeMake(0, 1)];
    WS(weakSelf)
    self.timeObserve = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        NSTimeInterval totalTime = CMTimeGetSeconds(weakSelf.player.currentItem.duration);//总时长
        NSTimeInterval currentTime = time.value / time.timescale;//当前时间进度
        weakSelf.videoSlider.value = currentTime / totalTime;
        weakSelf.currentTime = currentTime;
        [weakSelf pinpointActionWithSecond:(double)currentTime];
    }];
    
    // 添加视频播放结束通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidEndNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

//    [self.player play];

    [self createModelDataHandler];
    
    
    
    self.previewView = [[PreviewView alloc] init];
    [self.view addSubview:self.previewView];
    
//    [self.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(120);
//        make.height.mas_equalTo(160);
//        make.right.offset(-20);
//        make.top.offset(20);
//    }];
    [self.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(385.0/2);
        make.height.mas_equalTo(678/2);
        make.left.offset(SCR_HIGHT/2-385.0/4);
        make.top.offset(SCR_WIDTH/2-678.0/4);
    }];
    
    
    self.overlayView = [[OverlayView alloc] init];
    self.overlayView.opaque = NO;
    self.overlayView.clearsContextBeforeDrawing = YES;

    [self.previewView addSubview:self.overlayView];
//    [self.overlayView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.previewView.mas_width);
//        make.height.equalTo(self.previewView.mas_height);
//
//    }];
    [self.overlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.previewView.mas_width);
        make.height.equalTo(self.previewView.mas_height);

    }];
    
    
    self.cameraCapture.delegate = self;

    
    
//    let label  = UILabel.init(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
//    label.text = "test"
//    label.textColor = UIColor.red
//    overlayView .addSubview(label)
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.playerLayer.frame = CGRectMake( 0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        //此时处于主队列中
//        [self.cameraCapture rotateVideoWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    });
    
    
    _actionDetectorSelector = [[ActionDetectorSelector alloc] init];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.cameraCapture checkCameraConfigurationAndStartSession];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.cameraCapture stopSession];
}

/** 释放Self */
- (void)dealloc
{
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
    //AVPlayerItemDidPlayToEndTimeNotification
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)viewDidLayoutSubviews
{
    [self updateCameraPreviewFrame];
}

/// 创建模型，配置参数发生变化只需重新调用此方法即可
- (void)createModelDataHandler
{
    @try {
        ModelDataHandler *modelDataHandler = [[ModelDataHandler alloc] initWithThreadCount:self.cpuCount delegate:self.detectType error:nil];
        modelDataHandler.type = 1; // 1 横屏 0 竖屏
        
        self.modelDataHandler = modelDataHandler;
    } @catch (NSException *exception) {
//        NSLog(@"exception: %@", exception);
    } @finally {
        
    }
}

- (void)updateCameraPreviewFrame
{
//    [self.previewView setNeedsLayout];
    [self.previewView layoutIfNeeded];
    self.overlayViewFrame = self.overlayView.frame;
    self.previewViewFrame = self.previewView.frame;
    
    self.overlayView.layer.cornerRadius = 10;
    self.overlayView.clipsToBounds = YES;
    
    self.previewView.layer.cornerRadius = 10;
    self.previewView.clipsToBounds = YES;
}

#pragma mark -

- (CameraFeedManager *)cameraCapture
{
    if (!_cameraCapture) {
        _cameraCapture = [[CameraFeedManager alloc] initWithPreviewView:self.previewView isFront:YES];
    }
    return _cameraCapture;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (![self.view.subviews containsObject:_calibrateBodyView]) {
        [self.view addSubview:self.calibrateBodyView];
    }
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
}


#pragma mark - CameraFeedManagerDelegate

- (void)cameraFeedManager:(CameraFeedManager *)manager didOutput:(CVPixelBufferRef)pixelBuffer
{
    [self runModel:pixelBuffer];
}

// MARK: Session Handling Alerts
- (void)cameraFeedManagerDidEncounterSessionRunTimeError:(CameraFeedManager *)manager
{
//    self.resumeButton.isHidden = false
}

- (void)cameraFeedManager:(CameraFeedManager *)manager sessionWasInterrupted:(BOOL)canResumeManually
{
    // Updates the UI when session is interupted.
  //    if canResumeManually {
  //      self.resumeButton.isHidden = false
  //    } else {
  //      self.cameraUnavailableLabel.isHidden = false
  //    }
}

- (void)cameraFeedManagerDidEndSessionInterruption:(CameraFeedManager *)manager
{
    // Updates UI once session interruption has ended.
  //    self.cameraUnavailableLabel.isHidden = true
  //    self.resumeButton.isHidden = true

}

- (void)presentVideoConfigurationErrorAlert:(CameraFeedManager *)manager
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirguration Failed" message:@"Configuration of camera has failed." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)presentCameraPermissionsDeniedAlert:(CameraFeedManager *)manager
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera Permissions Denied" message:@"Camera permissions have been denied for this app. You can change this by going to Settings" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:settingsAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)runModel:(CVPixelBufferRef)pixelBuffer
{
//    [self runModel2:pixelBuffer];
    DetectResult *result = [self.actionDetectorSelector detectWithPixelbuffer:pixelBuffer seconds:self.currentTime];
    if (result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 启动
            [self handleBodyEnterOrLeaveWithScore:result.score];
            
            // 处理动作提示信息
            NSArray *motionMsgs = result.motionMsgs;
            if ([motionMsgs count]) {
                for (MotionMsg *msg in motionMsgs) {
                    NSLog(@"动作提示：%ld 动作类型：%ld", (long)msg.statusType, msg.msg);
                    int status = msg.statusType;
                    
                    if (status == 0) { // detected
                        
                    } else if (status == 1) { // undetected  1
                        [self handleStatusUndetectedWithMotionMsg:msg];
                    } else if (status == 2) { // good   10
                        [self handleStatusGoodWithMotionMsg:msg];
                    } else if (status == 3) { // bad   5
                        [self handleStatusBadWithMotionMsg:msg];
                        
                    }
                    if (self.isPlayGood) {
                        [self handleStatusGoodWithMotionMsg:msg];
                    }
                    
                }
            }
            
            if (result.score < self.minimumScore) {
                [self.overlayView clearResult];
                return;
            }
            
            [self.overlayView drawResultWithResult:result];

        });
    }
}




- (void)runModel2:(CVPixelBufferRef)pixelBuffer
{
    CGSize pixelBufferSize = CGSizeMake(CVPixelBufferGetWidth(pixelBuffer), CVPixelBufferGetHeight(pixelBuffer));
    
    CGAffineTransform ts = CGSizeTransformKeepAspect(self.overlayViewFrame.size, pixelBufferSize);
    CGRect modelInputRange = CGRectApplyAffineTransform(self.overlayViewFrame, ts);
    
    ResultData *result = [self.modelDataHandler oc_runPoseNetOn:pixelBuffer from:modelInputRange to:self.overlayViewFrame.size];
    
    
    if(result) {
        
//        NSLog(@"相机得到分值-------%f",result.score);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self handleBodyEnterOrLeaveWithResultData:result];
            
            //      self.tableView.reloadData()
                // If score is too low, clear result remaining in the overlayView.
                if (result.score < self.minimumScore) {
                    [self.overlayView clearResult];
                    return;
                }

            [self.overlayView drawResultWithResult:result];

        });
        
    }   else {
    
    
    }
}

#pragma mark - 暂停
- (StopTrainView *)stopTrainView
{
    if (!_stopTrainView) {
        _stopTrainView = [[StopTrainView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        _stopTrainView.backgroundColor = [UIColor colorWithHex:@"#333333" alpha:0.72];
        WS(weakSelf);
        _stopTrainView.backPlayVideoBlock = ^{
            [weakSelf removeStopTrainView];
            [weakSelf.navigationController dismissViewControllerAnimated:NO completion:^{
                UIViewController *viewC = [UIApplication sharedApplication].keyWindow.rootViewController;
                BaseNavigationController *navC = (BaseNavigationController *)viewC;
                [navC popViewControllerAnimated:YES];
            }];
        };
        
        _stopTrainView.continuePlayVideoBlock = ^{
            [weakSelf removeStopTrainView];
//            [weakSelf.player play];
            [weakSelf addStartTimer];
            
        };
    }
    
    return _stopTrainView;
}

- (void)removeStopTrainView
{
    for (UIView *view in self.stopTrainView.subviews) {
        [view removeFromSuperview];
    }
    
    [_stopTrainView removeFromSuperview];
    _stopTrainView = nil;
}

#pragma mark - 能量值
- (EnergyGetView *)energyGetView
{
    if (!_energyGetView) {
        _energyGetView = [[EnergyGetView alloc] initWithFrame:CGRectMake(16*2*Screen_Scale, 135, 57, 101)];
    }
    return _energyGetView;
}


#pragma mark - 倒计时
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-100.0/2, SCR_HIGHT/2-120.0/2, 100, 120)];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = fontBold(156);
        _timeLabel.textColor = [UIColor whiteColor];
    }
    return _timeLabel;;
}

#pragma mark - 校对身体
- (CalibrateBodyView *)calibrateBodyView
{
    if (!_calibrateBodyView) {
        _calibrateBodyView = [[CalibrateBodyView alloc] initWithFrame:CGRectMake(0, 0, SCR_HIGHT, SCR_WIDTH)];
    }

    return _calibrateBodyView;
}

- (void)removeCalibrateBodyView
{
    for (UIView *view in self.calibrateBodyView.subviews) {
        [view removeFromSuperview];
    }
    
    [_calibrateBodyView removeFromSuperview];
    _calibrateBodyView = nil;
}


#pragma mark - 处理身体进入，或离开时的逻辑
- (void)handleBodyEnterOrLeaveWithScore:(CGFloat)score
{
    //result.score为0.1，代表身体全部在相机内
    if (score > 0.1 && self.isLeave) {
        //#1BC2B1
        self.calibrateBodyView.coverView.backgroundColor = [UIColor colorWithHex:@"#1BC2B1" alpha:0.79];
        self.isLeave = NO;
        [self addStartTimer];
    }else if(score > 0.1 && !self.isLeave){
        
    }else if(score < 0.1 && self.isLeave){
        
    }else{

        if (self.isPlayStop) {
            return;;
        }
        [self.player pause];
        [self.view addSubview:self.calibrateBodyView];
        _calibrateBodyView.coverView.backgroundColor = [UIColor colorWithHex:@"#ffc1c1" alpha:0.79];
        _calibrateBodyView.botoomTiLab.text = @"嘿！你去哪了，赶紧动起来！";
        self.isLeave = YES;
        [self updateCameraViewFrameWithIsToCentre:YES];
        [self hideTimer];

    }
}


- (void)handleBodyEnterOrLeaveWithResultData:(ResultData *)result
{
    //result.score为0.1，代表身体全部在相机内
    if (result.score > 0.1 && self.isLeave) {
        //#1BC2B1
        self.calibrateBodyView.coverView.backgroundColor = [UIColor colorWithHex:@"#1BC2B1" alpha:0.79];
        self.isLeave = NO;
        [self addStartTimer];
    }else if(result.score > 0.1 && !self.isLeave){
        
    }else if(result.score < 0.1 && self.isLeave){
        
    }else{
        
        if (self.isPlayStop) {
            return;;
        }
        [self.player pause];
        [self.view addSubview:self.calibrateBodyView];
        _calibrateBodyView.coverView.backgroundColor = [UIColor colorWithHex:@"#ffc1c1" alpha:0.79];
        _calibrateBodyView.botoomTiLab.text = @"嘿！你去哪了，赶紧动起来！";
        self.isLeave = YES;
        [self updateCameraViewFrameWithIsToCentre:YES];
        [self hideTimer];

    }
}

- (void)updateCameraViewFrameWithIsToCentre:(BOOL)isToCentre
{
    if (isToCentre) {
        [self.previewView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(385.0/2);
            make.height.mas_equalTo(678/2);
            make.left.offset(SCR_max/2-385.0/4);
            make.top.offset(SCR_min/2-678.0/4);
        }];
    }else{
        [self.previewView mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(89);
            make.height.mas_equalTo(133);
            make.right.offset(-8);
            make.centerY.mas_equalTo(self.view);
    //        make.top.offset(20);
        }];
    }
    
    
    [self updateCameraPreviewFrame];

}

- (void)addStartTimer
{
    if (!_timer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimeCount) userInfo:self repeats:YES];
        _timer = timer;
    }
    _timeCount = 3;
//    [self.calibrateBodyView addSubview:self.timeLabel];
    [self.view addSubview:self.timeLabel];
    self.timeLabel.text = [NSString stringWithFormat:@"%lld",_timeCount];
    [_timer fire];
}

- (void)startTimeCount
{
    self.timeLabel.text = [NSString stringWithFormat:@"%lld",_timeCount];
    if (_timeCount <= 0) {
        [self hideTimer];
        [self removeCalibrateBodyView];
        [self.player play];
        [self updateCameraViewFrameWithIsToCentre:NO];
        [self videoStartNeedLoadView];
        self.isPlayStop = NO;
        
    }
    _timeCount--;
}


//开始训练时，加载界面
-(void)videoStartNeedLoadView
{
    if (!_videoSlider) {
        [self.view addSubview:self.energyGetView];
        
        _videoSlider = [[SelVideoSlider alloc] init];
        [self.view addSubview:_videoSlider];
        _videoSlider.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
        [_videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(0);
            make.height.equalTo(@6);
            make.top.equalTo(self.view.mas_top).offset(0);
        }];
        [_videoSlider setThumbImage:[UIImage imageNamed:@"train_slider"] forState:UIControlStateNormal];
        _videoSlider.layer.cornerRadius = 3;
        _videoSlider.clipsToBounds = YES;
        
        
//        CGFloat max = MAX(SCR_WIDTH, SCR_HIGHT);
//        CGFloat min = MIN(SCR_WIDTH, SCR_HIGHT);
        _actionVigourView = [[ActionVigourView alloc] initWithFrame:CGRectMake(SCR_max/2-210/2, 32, 210, 16)];
        [self.view addSubview:_actionVigourView];
        _actionVigourView.layer.borderWidth = 1;
        _actionVigourView.layer.borderColor = [[UIColor colorWithHex:@"#00FFDD"] CGColor];
        
        
        _bubbleImageView  = [[UIImageView alloc] init];
        _bubbleImageView.hidden  = YES;
        _bubbleImageView.userInteractionEnabled = YES;
        [self.view addSubview:_bubbleImageView];
        
        _messageLabel      = [[UILabel alloc] init];
        _messageLabel.hidden      = YES;
        [self.view addSubview:_messageLabel];
        _messageLabel.numberOfLines=0;
        _messageLabel.lineBreakMode=NSLineBreakByWordWrapping;
        _messageLabel.font = fontApp(12);
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        
//        _bubbleImageView.hidden = NO;
//        _bubbleImageView.frame = [self bubbleFrame];
        _bubbleImageView.image = [[UIImage imageNamed:@"bubble"] stretchableImageWithLeftCapWidth:20 topCapHeight:40];
        
//        _messageLabel.hidden = NO;
//        _messageLabel.frame = [self messageFrame];
//        _messageLabel.text = @"下蹲膝盖不要超过脚尖哦";
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_max-22-16, SCR_min-22-34, 22, 22)];
        [self.view addSubview:iconImageView];
        iconImageView.backgroundColor = [UIColor redColor];
        iconImageView.layer.cornerRadius = 11;
        iconImageView.clipsToBounds = YES;
        iconImageView.image = [UIImage imageNamed:@"home_banner"];
    }
    
    
    
    
}

- (void)hideTimer
{
    [_timer invalidate];
    _timer = nil;
    _timeCount = 0;
    [self.timeLabel removeFromSuperview];
    self.timeLabel = nil;
}


#pragma mark - 提示消息
- (CGRect)bubbleFrameWithMessage:(NSString *)message
{
    CGRect rect = CGRectZero;
    rect = [self messageFrameWithMessage:message];
    rect.origin.x =  rect.origin.x + (-10);
    rect.size.width =  rect.size.width + 12;
    return rect;
}

- (CGRect)messageFrameWithMessage:(NSString *)message
{
    CGRect rect = CGRectZero;
    CGFloat maxWith = SCR_max * 0.7 - 60;//42
     CGSize size = [self labelAutoCalculateRectWith:message Font:[UIFont fontWithName:@"PingFangSC-Regular" size:12] MaxSize:CGSizeMake(maxWith, MAXFLOAT)];

    rect = CGRectMake(SCR_max-(size.width + 10+22+16), SCR_min-25-(size.height > 34 ? size.height : 34), size.width + 10, size.height > 34 ? size.height : 34);;
    return rect;
}

- (CGSize)labelAutoCalculateRectWith:(NSString *)text Font:(UIFont *)textFont MaxSize:(CGSize)maxSize
{
    NSDictionary *attributes = @{NSFontAttributeName: textFont};
    CGRect rect = [text boundingRectWithSize:maxSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isLeave && !_timer) {
        [self.player pause];
        [self.view addSubview:self.stopTrainView];
        self.isPlayStop = YES;
    }
}

- (void)playDidEndNotification:(NSNotification *)notification
{
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        UIViewController *viewC = [UIApplication sharedApplication].keyWindow.rootViewController;
        MSTabBarController *tabbarVC = (MSTabBarController *)viewC;
        BaseNavigationController *navC = tabbarVC.childViewControllers[0];
        ASTrainReportController *vc = [[ASTrainReportController alloc] init];
        [navC pushViewController:vc animated:YES];
    }];

}


#pragma mark - 定点触发语音
- (void)pinpointActionWithSecond:(double)second
{
    NSString *resource = @"";
    NSString *extention = @"";
    if (second == 16) {
        resource = @"action1";
        extention = @"mp3";
    }else if (second == 40){
        resource = @"action2";
        extention = @"mp3";
    }else{
        return;
    }
    
    _bubbleImageView.hidden = YES;
    _messageLabel.hidden = YES;

    [[SoundPlayCenter defaultCenter] playAudioSoundWithResource:resource Extention:extention];
    //    [PlaySoundService playSoundName:[NSString stringWithFormat:@"%@.%@",frontStr,backStr]];

}

#pragma mark - 回调触发
//good  得分:10
- (void)handleStatusGoodWithMotionMsg:(MotionMsg *)msg
{
    if (self.actionGoodCount > 5) {
        self.actionGoodCount = 0;
        
    }
    
    if (self.actionGoodCount == 5) {
        self.isPlayGood = NO;
        msg.msg = @"";
    }
    self.actionGoodCount++;
    if ([[NSString stringForId:msg.msg] isEqual:@""] && self.actionGoodCount == 5) {
        self.bubbleImageView.hidden = YES;
        self.messageLabel.hidden = YES;
        NSSet *soundSet = [NSSet setWithObjects:@"亲爱的，你是不是偸偸练过呀？做得太好了！",
                           @"太棒了！结束后奖励你一套拉伸！",
                           @"哇哦！动作非常完美！",
                           @"优秀！请继续你的表演！",
                           @"有点小性感哦！我都看醉了！",
                           @"状态不错，继续保持！", nil];
        [[SoundPlayCenter defaultCenter] playAudioSoundWithResource:[soundSet anyObject] Extention:@"mp3"];
    }else if ([[NSString stringForId:msg.msg] isEqual:@""] && self.actionGoodCount != 5){
        self.bubbleImageView.hidden = YES;
        self.messageLabel.hidden = YES;
    }else{
        self.bubbleImageView.hidden = NO;
        self.messageLabel.hidden = NO;
        self.bubbleImageView.frame = [self bubbleFrameWithMessage:msg.msg];
        self.messageLabel.frame = [self messageFrameWithMessage:msg.msg];
        self.messageLabel.text = msg.msg;
    }
    self.actionVigourView.value = 10;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.energyGetView.value = 10/100.0;
//    });
    self.energyGetView.value = 10;
    
    
}

//bad   得分:5
- (void)handleStatusBadWithMotionMsg:(MotionMsg *)msg
{
    self.actionGoodCount = 0;
    if ([[NSString stringForId:msg.msg] isEqual:@""]) {
        self.bubbleImageView.hidden = YES;
        self.messageLabel.hidden = YES;
//        [[SoundPlayCenter defaultCenter] playAudioSoundWithResource:@"action2" Extention:@"mp3"];
    }else{
        self.bubbleImageView.hidden = NO;
        self.messageLabel.hidden = NO;
        self.bubbleImageView.frame = [self bubbleFrameWithMessage:msg.msg];
        self.messageLabel.frame = [self messageFrameWithMessage:msg.msg];
        self.messageLabel.text = msg.msg;
    }
    self.actionVigourView.value = 5;
    self.energyGetView.value = 5;
    
}

//undetected   得分:1
- (void)handleStatusUndetectedWithMotionMsg:(MotionMsg *)msg
{
    if ([[NSString stringForId:msg.msg] isEqual:@""]) {
        self.bubbleImageView.hidden = YES;
        self.messageLabel.hidden = YES;
    }else{
        self.bubbleImageView.hidden = NO;
        self.messageLabel.hidden = NO;
        self.bubbleImageView.frame = [self bubbleFrameWithMessage:msg.msg];
        self.messageLabel.frame = [self messageFrameWithMessage:msg.msg];
        self.messageLabel.text = msg.msg;
    }
    
    self.actionVigourView.value = 1;
    self.energyGetView.value = 1;
    
//    self.actionGoodCount++;
//    [[SoundPlayCenter defaultCenter] playAudioSoundWithResource:@"action1" Extention:@"mp3"];
}

@end

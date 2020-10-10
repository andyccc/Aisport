//
//  VideoPreviewVIew.m
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import "VideoPreviewVIew.h"
#import "SelPlayerConfiguration.h"
#import "SelVideoPlayer.h"

@interface VideoPreviewVIew ()

@property (nonatomic, strong) SelPlayerConfiguration *configuration;
@property (nonatomic, strong) SelVideoPlayer *player;

@end

@implementation VideoPreviewVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
        configuration.shouldAutoPlay = YES;     //自动播放
        configuration.supportedDoubleTap = YES;     //支持双击播放暂停
        configuration.shouldAutorotate = NO;   //自动旋转
        configuration.repeatPlay = NO;     //重复播放
        configuration.shouldAutorotate = NO;
        configuration.statusBarHideState = SelStatusBarHideStateFollowControls;     //设置状态栏隐藏
        configuration.videoGravity = SelVideoGravityResizeAspect;   //拉伸方式
        _configuration = configuration;
        
        _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 212*2*Screen_Scale) configuration:configuration];
        [self addSubview:_player];
        _player.center = self.center;
        
        UIView *deleteBgView = [[UIView alloc] initWithFrame:CGRectMake(SCR_WIDTH-14-18, _player.top+8, 18, 18)];
        [self addSubview:deleteBgView];
        deleteBgView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.45];
        deleteBgView.hidden = YES;
        
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH-14-18, _player.top+8, 18, 18)];
        [self addSubview:deleteBtn];
        [deleteBtn setImage:[UIImage imageNamed:@"cancle_play"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(canclePlayVideo) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.hidden = YES;
//        _deleteBtn = deleteBtn;
        
    }
    return self;
}

- (void)setVideoUrl:(NSString *)videoUrl
{
    _videoUrl = videoUrl;
    _player.contentUrl = videoUrl;     //设置播放数据源
}

- (void)canclePlayVideo
{
    if (self.canclePlayVideoBlock) {
        self.canclePlayVideoBlock();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches  anyObject];
    if (touch.view == _player) {
        return;
    }
    if (touch.view == _player.playbackControls) {
        return;
    }
    
    if (self.canclePlayVideoBlock) {
        self.canclePlayVideoBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

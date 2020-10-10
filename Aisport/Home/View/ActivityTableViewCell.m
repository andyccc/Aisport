//
//  ActivityTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "ActivityTableViewCell.h"
#import "UIButton+WebCache.h"

@implementation ActivityTableViewCell
{
    NSDateFormatter *df;
    NSTimeInterval _totalSeconds;
    NSTimer *timer;
    id _actData;
}

- (void)initSelf
{
    df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    self.countDownView = [[UIButton alloc] init];
    self.countDownView.width = UIValue(167);
    self.countDownView.height = UIValue(169);
    self.countDownView.left = UIValue(16);
    [self.countDownView setBackgroundImage:[UIImage imageNamed:@"icon_count_time"] forState:UIControlStateNormal];
    [self.countDownView addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.countDownView.tag = 0;
    [self.contentView addSubview:self.countDownView];
    
    self.timeBgView = [[UIImageView alloc] init];
    self.timeBgView.width = UIValue(83);
    self.timeBgView.height = UIValue(20);
    self.timeBgView.image = [UIImage imageNamed:@"icon_time_bg"];
    self.timeBgView.centerX = self.countDownView.centerX;
    [self.contentView addSubview:self.timeBgView];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:self.timeBgView.frame];
    self.timeLabel.font = FontR(14);
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.text = @"00:00:00";
}

- (void)fillData:(id)data
{
    NSArray *list = data[@"data"];
    if ([list count]) {
        // 取第一个
        _actData = list[0];

//        [self.countDownView sd_setBackgroundImageWithURL:[NSURL URLWithString:_actData[@"cover"]] forState:UIControlStateNormal];
        [self startActivityTimer:YES];
    }
    
    self.btnBlock = data[@"block"];
}

- (void)startActivityTimer:(BOOL)ready
{
//    NSString *stime = ready ? _actData[@"warmUpStartTime"] :_actData[@"startTime"];
//    NSString *etime = ready ? _actData[@"startTime"] : _actData[@"endTime"];

    NSString *stime = ready ? _actData[@"curTime"] :_actData[@"curTime"];
    NSString *etime = ready ? _actData[@"startTime"] : _actData[@"endTime"];

    
    NSDate *edate = [df dateFromString:etime];
    NSDate *sdate = [df dateFromString:stime];
    
    NSTimeInterval seconds = ([edate timeIntervalSince1970] - [sdate timeIntervalSince1970]);
    if (seconds <= 0) {
        if (ready) {
            [self startActivityTimer:NO];
        } else {
            [self stopTimer];
        }
    } else {
        [self startTimer:seconds];
    }
}

- (void)btnAction:(UIButton *)btn
{
    !self.btnBlock ?: self.btnBlock(btn.tag);
}

- (void)stopTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }

}

- (void)startTimer:(NSTimeInterval)seconds
{
    _totalSeconds = seconds;
    [self stopTimer];
    
    @weakify(self);
    timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        @strongify(self);
        [self ticker];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)ticker
{
    if (_totalSeconds-- <= 0) {
        [self startActivityTimer:NO];
        return;
    }
    
    NSString *time = [self formatTimeFromSeconds:_totalSeconds];
    self.timeLabel.text = time;
}

- (NSString *)formatTimeFromSeconds:(long)totalSeconds
{
//    NSInteger days = (int)(totalSeconds/(3600*24));
//    NSInteger hours = (int)((totalSeconds-days*24*3600)/3600);
//    NSInteger minutes = (int)(totalSeconds-days*24*3600-hours*3600)/60;
//    NSInteger seconds = totalSeconds - days*24*3600 - hours*3600 - minutes*60;
    
    long seconds = totalSeconds % 60;
    long minutes = (totalSeconds%3600)/60;
    long hours = totalSeconds / 60 / 60;
    return [NSString stringWithFormat:@"%ld:%02ld:%02ld", hours, minutes, seconds];
}

- (NSMutableAttributedString *)createAttributedString:(NSString *)title info:(NSString *)info
{
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *string1 = [
      [NSMutableAttributedString alloc] initWithString:title
      attributes: @{
        NSFontAttributeName: FontBoldR(20),
        NSObliquenessAttributeName: @(0.3),// 向右倾斜
//        NSExpansionAttributeName: @(0.8),// 拉伸
        NSForegroundColorAttributeName: [UIColor whiteColor]
    }];
    
    NSMutableAttributedString *string2 = [
      [NSMutableAttributedString alloc] initWithString:info
      attributes: @{
        NSFontAttributeName: FontR(10),
        NSForegroundColorAttributeName: [[UIColor whiteColor] colorWithAlphaComponent:0.6]
    }];
    
    [attstring appendAttributedString:string1];
    [attstring appendAttributedString:string2];
    return attstring;
}


@end

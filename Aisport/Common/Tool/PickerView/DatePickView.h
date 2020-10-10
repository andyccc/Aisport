//
//  DatePickView.h
//  yimei
//
//  Created by Pure Ruins on 14-10-11.
//  Copyright (c) 2014年 Pure Ruins. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DatePickViewSelectBlock)(NSString *stringDate, NSDate *date);

#define datepickerViewHeight 215
#define toolBarHeight 31

@interface DatePickView : UIView

@property(nonatomic, strong) UIView *pickFatherView;
@property(nonatomic, strong) UIView *pickContentView;
@property(nonatomic, strong) UIImageView *imageToolBackground;
@property(nonatomic, strong) UILabel *labelTitle;
@property(nonatomic, strong) UIButton *buttonConfirm;
@property(nonatomic, strong) UIButton *buttonCancel;
@property(nonatomic, strong) UIDatePicker *pickerView;
@property(nonatomic, strong) NSDateFormatter *formate;
@property(nonatomic, copy) DatePickViewSelectBlock block;
@property(nonatomic) UIDatePickerMode pickerMode;
@property(nonatomic, strong) NSDate *date; //选择器默认时间
/**
 *  显示日期选择器
 *
 *  @param formate    日期格式
 *  @param pickerMode 日期选择器类型
 *  @param block      返回block
 */
-(void)showWithDateFormate:(NSDateFormatter *)formate PickerMode:(UIDatePickerMode)pickerMode Block:(DatePickViewSelectBlock)block;
-(void)animateDisappear;
@end

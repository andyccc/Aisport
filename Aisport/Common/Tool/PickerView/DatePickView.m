//
//  DatePickView.m
//  yimei
//
//  Created by Pure Ruins on 14-10-11.
//  Copyright (c) 2014年 Pure Ruins. All rights reserved.
//

#import "DatePickView.h"
@implementation DatePickView

-(void)setDate:(NSDate *)date{
    
    _date = date;
     self.pickerView.date = _date;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(id)init{
    self = [super init];
    if(self){
        // Initialization code
        
        self.frame = [[UIScreen mainScreen] bounds];
        
        //背景视图
        self.pickFatherView = [[UIView alloc] initWithFrame:self.frame];
        self.pickFatherView.backgroundColor = [UIColor blackColor];
        self.pickFatherView.alpha = 0.3;
        [self addSubview:self.pickFatherView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self.pickFatherView addGestureRecognizer:tap];
        
        //内容视图
        self.pickContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-120, self.frame.size.width, toolBarHeight + datepickerViewHeight)];
        self.pickContentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickContentView];
        
        //选择器
        self.pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, toolBarHeight - 20, self.frame.size.width, datepickerViewHeight)];
        
       
        [self setDatePickerTextColor:[UIColor colorForHex:@"476ed7"]];
        
        [self.pickContentView addSubview:self.pickerView];
        
        //确定按钮
        self.buttonConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonConfirm.frame = CGRectMake(SCR_WIDTH-40-5, 9.5, 40, 30);
        self.buttonConfirm.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.buttonConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [self.buttonConfirm setTitleColor:[UIColor colorForHex:@"476ed7"] forState:UIControlStateNormal];
//        [self.buttonConfirm setBackgroundColor:[UIColor colorForHex:@"3dab49"]];
        [self.buttonConfirm addTarget:self action:@selector(ConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.pickContentView addSubview:self.buttonConfirm];
//        self.buttonConfirm.layer.cornerRadius = 3.0;
        
        //取消按钮
        self.buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonCancel.frame = CGRectMake(9.5, 9.5, 40, 30);
        self.buttonCancel.titleLabel.font = [UIFont systemFontOfSize:16];
//        [self.buttonCancel setBackgroundColor:[UIColor colorForHex:@"c1c1c1"]];
        [self.buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.buttonCancel setTitleColor:[UIColor colorForHex:@"476ed7"] forState:UIControlStateNormal];
        [self.buttonCancel addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.pickContentView addSubview:self.buttonCancel];
//        self.buttonCancel.layer.cornerRadius = 3.0;
        
//        self.pickContentView.layer.cornerRadius = 4.0;
//        self.pickContentView.layer.borderWidth = 0.5;
        self.pickContentView.layer.borderColor = [UIColor colorWithHex:@"#36D987"].CGColor;
    }
    return self;
}

#pragma mark - Private Methods

/**
 *  确定操作
 *
 *  @param button 确定按钮
 */
-(void)ConfirmAction:(UIButton *)button{
    NSDate *date = self.pickerView.date;
    NSString *stringDateFormate = [[NSString alloc] init];
    
    if(self.formate){
        stringDateFormate = [self.formate stringFromDate:date];
    }
    
    if(self.block){
        self.block(stringDateFormate, date);
    }
    
    [self animateDisappear];
}

/**
 *  取消操作
 *
 *  @param button 取消按钮
 */
-(void)CancelAction:(UIButton *)button{
    [self animateDisappear];
}

- (void)tap {
    [self animateDisappear];
}

#pragma mark - Public Methods

-(void)showWithDateFormate:(NSDateFormatter *)formate PickerMode:(UIDatePickerMode)pickerMode Block:(DatePickViewSelectBlock)block{
    self.block = block;
    self.formate = formate;
    self.pickerView.datePickerMode = pickerMode;
    
    [self animateAppear];
}

-(void)animateAppear{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.pickContentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, toolBarHeight + datepickerViewHeight);
    
    [UIView animateWithDuration:0.4 animations:^{
        self.pickContentView.frame = CGRectMake(0, (self.frame.size.height- toolBarHeight - datepickerViewHeight), self.frame.size.width, toolBarHeight + datepickerViewHeight);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)animateDisappear{
    [UIView animateWithDuration:0.4 animations:^{
        self.pickContentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, toolBarHeight + datepickerViewHeight);
    } completion:^(BOOL finished) {

[[NSNotificationCenter defaultCenter] postNotificationName:@"SMNotificationCancelColor" object:self];
        self.pickFatherView.hidden = YES;
        [self removeFromSuperview];
    }];
}
- (void)setDatePickerTextColor:(UIColor *)color{
    unsigned outCount;
    int i;
    
    objc_property_t *pProperty = class_copyPropertyList([self.pickerView class], &outCount);
    for (i = outCount -1; i >= 0; i--)
    {
        // 循环获取属性的名字   property_getName函数返回一个属性的名称
        NSString *getPropertyName = [NSString stringWithCString:property_getName(pProperty[i]) encoding:NSUTF8StringEncoding];

        if([getPropertyName isEqualToString:@"textColor"])
        {
            [self.pickerView setValue:color forKey:@"textColor"];
        }
    }
}
@end

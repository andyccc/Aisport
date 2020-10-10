//
//  ScheduleDatePickerView.m
//  HROA
//
//  Created by luoda on 15/10/12.
//  Copyright © 2015年 PureRuins. All rights reserved.
//

#import "ScheduleDatePickerView.h"
@implementation ScheduleDatePickerView

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
        
        //内容视图
        self.pickContentView = [[UIView alloc] initWithFrame:CGRectMake(49, self.frame.size.height/2-120, self.frame.size.width-98, 241)];
        self.pickContentView.backgroundColor = [UIColor colorForHex:@"f8f8f8"];
        [self addSubview:self.pickContentView];
        self.pickContentView.layer.cornerRadius = 2.0;
        
        //工具栏
        self.imageToolBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-98, toolBarHeight)];
        self.imageToolBackground.backgroundColor = [UIColor colorForHex:@"3dab49"];
        self.imageToolBackground.userInteractionEnabled = YES;
        [self.pickContentView addSubview:self.imageToolBackground];
        
        //标题
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-98, toolBarHeight)];
        self.labelTitle.backgroundColor = [UIColor clearColor];
        self.labelTitle.font = [UIFont systemFontOfSize:14];
        self.labelTitle.textColor = [UIColor whiteColor];
        self.labelTitle.text = @"请选择日期";
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        [self.imageToolBackground addSubview:self.labelTitle];
        
        //确定按钮
        self.buttonConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonConfirm.frame = CGRectMake(12, self.pickContentView.frame.size.height - 41, (self.pickContentView.frame.size.width - 12 * 2 - 2) / 2, 27);
        self.buttonConfirm.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.buttonConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [self.buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buttonConfirm setBackgroundColor:[UIColor colorForHex:@"3dab49"]];
        [self.buttonConfirm addTarget:self action:@selector(ConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.pickContentView addSubview:self.buttonConfirm];
        self.buttonConfirm.layer.cornerRadius = 3.0;
        
        //取消按钮
        self.buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonCancel.frame = CGRectMake(self.buttonConfirm.frame.size.width+self.buttonConfirm.frame.origin.x+2, self.pickContentView.frame.size.height - 41, (self.pickContentView.frame.size.width - 12 * 2 - 2) / 2, 27);
        self.buttonCancel.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.buttonCancel setBackgroundColor:[UIColor colorForHex:@"c1c1c1"]];
        [self.buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.buttonCancel setTitleColor:[UIColor colorForHex:@"818181"] forState:UIControlStateNormal];
        [self.buttonCancel addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.pickContentView addSubview:self.buttonCancel];
        self.buttonCancel.layer.cornerRadius = 3.0;
        
        //选择器
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(12, toolBarHeight+10, self.frame.size.width-123, pickerViewHeight)];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        [self.pickContentView addSubview:self.pickerView];
        
        self.pickerView.layer.cornerRadius = 4.0;
        self.pickerView.layer.borderWidth = 0.5;
        self.pickerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        //年
        UILabel *labelYear = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 23)];
        labelYear.center = CGPointMake(self.pickerView.center.x-5, self.pickerView.center.y);
        labelYear.backgroundColor = [UIColor clearColor];
        labelYear.font = [UIFont systemFontOfSize:17];
        labelYear.textColor = [UIColor blackColor];
        labelYear.text = @"年";
        labelYear.textAlignment = NSTextAlignmentCenter;
        [self.pickContentView addSubview:labelYear];
        
        //月
        UILabel *labelMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 23)];
        labelMonth.center = CGPointMake(self.pickerView.frame.size.width+self.pickerView.frame.origin.x-20, self.pickerView.center.y);
        labelMonth.backgroundColor = [UIColor clearColor];
        labelMonth.font = [UIFont systemFontOfSize:17];
        labelMonth.textColor = [UIColor blackColor];
        labelMonth.text = @"月";
        labelMonth.textAlignment = NSTextAlignmentCenter;
        [self.pickContentView addSubview:labelMonth];
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
    if(self.block){
        NSInteger row1 = 0,row2 = 0,row3 = 0;
        NSString *title1,*title2,*title3;
        row1 = [self.pickerView selectedRowInComponent:0];
        title1 = [NSString stringWithFormat:@"%@",[self.arraySource1 objectAtIndex:row1]];
        if(self.numToSelect >= 2 ){
            row2 = [self.pickerView selectedRowInComponent:1];
            title2 = [NSString stringWithFormat:@"%@",[self.arraySource2 objectAtIndex:row2]];
        }
        if(self.numToSelect >= 3 ){
            row3 = [self.pickerView selectedRowInComponent:2];
            title3 = [NSString stringWithFormat:@"%@",[self.arraySource3 objectAtIndex:row3]];
        }
        self.block(title1,title2,title3,(int)row1,(int)row2,(int)row3);
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

#pragma mark - Public Methods

-(void)showWithArray:(NSMutableArray *)arraySource1 Source2:(NSMutableArray *)arraySource2 Source3:(NSMutableArray *)arraySource3  Block:(DataPickViewSelectBlock)block{
    self.numToSelect = 0;
    self.arraySource1 = arraySource1;
    self.arraySource2 = arraySource2;
    self.arraySource3 = arraySource3;
    
    if(self.arraySource1.count > 0){
        self.numToSelect ++ ;
    }
    if(self.arraySource2.count > 0){
        self.numToSelect ++ ;
    }
    //    if(self.arraySource3.count > 0){
    //        self.numToSelect ++ ;
    //    }
    
    self.block = block;
    
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:[arraySource3.firstObject integerValue] inComponent:0 animated:NO];
    [self.pickerView selectRow:[arraySource3.lastObject integerValue] inComponent:1 animated:NO];
    [self animateAppear];
}

-(void)animateAppear{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.pickContentView.frame = CGRectMake(49, self.frame.size.height, self.frame.size.width-98, 241);
    
    [UIView animateWithDuration:0.4 animations:^{
        self.pickContentView.frame = CGRectMake(49, self.frame.size.height/2-120, self.frame.size.width-98, 241);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)animateDisappear{
    [UIView animateWithDuration:0.4 animations:^{
        self.pickContentView.frame = CGRectMake(49, self.frame.size.height, self.frame.size.width-98, 241);
    } completion:^(BOOL finished) {
        self.pickFatherView.hidden = YES;
        [self removeFromSuperview];
    }];
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return [self.arraySource1 count];
    }else if (component == 1){
        return [self.arraySource2 count];
    }else if (component == 2){
        return [self.arraySource3 count];
    }else{
        return 0;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.numToSelect;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return [NSString stringWithFormat:@"%@",[self.arraySource1 objectAtIndex:row]];
    }else if (component == 1){
        return [NSString stringWithFormat:@"%@",[self.arraySource2 objectAtIndex:row]];
    }else if (component == 2){
        return [NSString stringWithFormat:@"%@",[self.arraySource3 objectAtIndex:row]];
    }else{
        return nil;
    }
}

@end

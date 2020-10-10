//
//  DataPickView.m
//  yimei
//
//  Created by Pure Ruins on 14-10-13.
//  Copyright (c) 2014年 Pure Ruins. All rights reserved.
//

#import "DataPickView.h"
#import "UIColor+ICCategory.h"

@implementation DataPickView

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
        self.pickContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, 215)];
        self.pickContentView.backgroundColor = [UIColor colorForHex:@"f8f8f8"];
        [self addSubview:self.pickContentView];
        self.pickContentView.layer.cornerRadius = 2.0;
        
        //确定按钮
        self.buttonConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonConfirm.frame = CGRectMake(SCR_WIDTH-33-5, 9.5, 33, 16);
        self.buttonConfirm.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.buttonConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [self.buttonConfirm setTitleColor:[UIColor colorForHex:@"476ed7"] forState:UIControlStateNormal];
        //        [self.buttonConfirm setBackgroundColor:[UIColor colorForHex:@"3dab49"]];
        [self.buttonConfirm addTarget:self action:@selector(ConfirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.pickContentView addSubview:self.buttonConfirm];
        //        self.buttonConfirm.layer.cornerRadius = 3.0;
        
        //取消按钮
        self.buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonCancel.frame = CGRectMake(9.5, 9.5, 33, 16);
        self.buttonCancel.titleLabel.font = [UIFont systemFontOfSize:16];
        //        [self.buttonCancel setBackgroundColor:[UIColor colorForHex:@"c1c1c1"]];
        [self.buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.buttonCancel setTitleColor:[UIColor colorForHex:@"476ed7"] forState:UIControlStateNormal];
        [self.buttonCancel addTarget:self action:@selector(CancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.pickContentView addSubview:self.buttonCancel];
        //选择器
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 35, self.frame.size.width, 180)];
//           [self setDatePickerTextColor:RGBA(54, 217, 135, 1)];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        [self.pickContentView addSubview:self.pickerView];

    }
    return self;
}

#pragma mark - Private Methods

/**
 *  确定操作
 *
 *  @param button 确定按钮
 */
-(void)ConfirmAction{
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
-(void)CancelAction{
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
    if(self.arraySource3.count > 0){
        self.numToSelect ++ ;
    }
    
    self.block = block;
    
    [self.pickerView reloadAllComponents];
    if(self.numToSelect > 1){
        [self.pickerView selectRow:[arraySource3.firstObject integerValue] inComponent:0 animated:NO];
    }
    if(self.numToSelect > 2){
        [self.pickerView selectRow:[arraySource3.lastObject integerValue] inComponent:1 animated:NO];
    }
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
[[NSNotificationCenter defaultCenter] postNotificationName:@"SMNotificationRestoreTableViewFrame" object:self];
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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.adjustsFontSizeToFitWidth = YES;

        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        
        [pickerLabel setFont:fontApp(14)];
        
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
    
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

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(self.didSelect)
    {
        self.didSelect(row, component);
    }
}

@end

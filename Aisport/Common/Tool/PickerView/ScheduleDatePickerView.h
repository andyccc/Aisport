//
//  ScheduleDatePickerView.h
//  HROA
//
//  Created by luoda on 15/10/12.
//  Copyright © 2015年 PureRuins. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DataPickViewSelectBlock)(NSString *stringData1, NSString *stringData2, NSString *stringData3, int selectInt1, int selectInt2, int selectInt3);

#define pickerViewHeight 150
#define toolBarHeight 31

@interface ScheduleDatePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>

@property(nonatomic, strong) UIView *pickFatherView;
@property(nonatomic, strong) UIView *pickContentView;
@property(nonatomic, strong) UIImageView *imageToolBackground;
@property(nonatomic, strong) UILabel *labelTitle;
@property(nonatomic, strong) UIButton *buttonConfirm;
@property(nonatomic, strong) UIButton *buttonCancel;
@property(nonatomic, strong) UIPickerView *pickerView;

@property(nonatomic) int numToSelect;
@property(nonatomic, strong) NSMutableArray *arraySource1;
@property(nonatomic, strong) NSMutableArray *arraySource2;
@property(nonatomic, strong) NSMutableArray *arraySource3;
@property(nonatomic, copy) DataPickViewSelectBlock block;

-(void)showWithArray:(NSMutableArray *)arraySource1 Source2:(NSMutableArray *)arraySource2 Source3:(NSMutableArray *)arraySource3  Block:(DataPickViewSelectBlock)block;

@end

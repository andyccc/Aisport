//
//  DataPickView.h
//  yimei
//
//  Created by Pure Ruins on 14-10-13.
//  Copyright (c) 2014年 Pure Ruins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleDatePickerView.h"

typedef void (^DataPickViewSelectBlock)(NSString *stringData1, NSString *stringData2, NSString *stringData3, int selectInt1, int selectInt2, int selectInt3);

@interface DataPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

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
@property(nonatomic, copy) void (^didSelect)(int row,int com);

-(void)showWithArray:(NSMutableArray *)arraySource1 Source2:(NSMutableArray *)arraySource2 Source3:(NSMutableArray *)arraySource3  Block:(DataPickViewSelectBlock)block;

@end

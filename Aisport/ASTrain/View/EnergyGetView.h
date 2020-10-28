//
//  EnergyGetView.h
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnergyGetView : UIView

@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, assign) long value;

@end

NS_ASSUME_NONNULL_END

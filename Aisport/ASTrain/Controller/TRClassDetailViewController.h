//
//  ClassDetailViewController.h
//  aisport
//
//  Created by Apple on 2020/10/16.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class HomeListModel;
@interface TRClassDetailViewController : BaseViewController

//@property (nonatomic, strong) HomeListModel *selModel;
@property (nonatomic, strong) NSString *codeId;

@end

NS_ASSUME_NONNULL_END

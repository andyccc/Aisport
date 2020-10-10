//
//  SearchView.h
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    SEARCHER_START_STATE = 0, //开始搜索
    SEARCHER_CONTENT_CHANGE_STATE = 1, //搜索改变内容
    SEARCHER_RETURN_STATE = 2, //搜索回车搜索
    SEARCHER_CLEAR_STATE = 3, //清空搜索内容
    SEARCHER_CANCEL_STATE = 4, //取消搜索状态
}SEARCHER_VIEW_STATE;

@interface SearchView : UIView

@property (nonatomic, copy) void(^textFieldStartBlcok)(SEARCHER_VIEW_STATE state);//开始搜索
@property (nonatomic, copy) void(^textFieldChangeBlock)(NSString *textStr, SEARCHER_VIEW_STATE state);//搜索内容改变
@property (nonatomic, copy) void(^textFieldSearchBlock)(NSString *textStr, SEARCHER_VIEW_STATE state);//键盘点击搜索
@property (nonatomic, copy) void(^textFieldClearBlock)(SEARCHER_VIEW_STATE state);//清空搜索内容
@property (nonatomic, copy) void(^cancelActionBlock)(SEARCHER_VIEW_STATE state);

- (void)fillData:(NSString *)text;
- (void)becomeFirstResponder;
+ (CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END

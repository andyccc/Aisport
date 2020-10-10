//
//  SexViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "SexViewController.h"
#import "TitleBtnView.h"

@interface SexViewController ()

@property (nonatomic, strong) TitleBtnView *maleBtnView;
@property (nonatomic, strong) TitleBtnView *femaleBtnView;


@end

@implementation SexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"昵称";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F8F8F7"];
    
    [self createView];
    [self updateSelected:self.sex];
}

- (void)selectAction:(int)sex
{
    [self updateSelected:sex];
    
    !self.finishBlock ?: self.finishBlock(sex);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView
{
    _maleBtnView = [[TitleBtnView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCR_WIDTH, uiv(78))];
    [_maleBtnView setTitle:@"男"];
    @weakify(self);
    _maleBtnView.btnBlock = ^{
        @strongify(self);
        [self selectAction:0];
    };
    [self.view addSubview:_maleBtnView];
    
    
    _femaleBtnView = [[TitleBtnView alloc] initWithFrame:CGRectMake(0, _maleBtnView.bottom, SCR_WIDTH, uiv(78))];
    [_femaleBtnView setTitle:@"女"];

    _femaleBtnView.btnBlock = ^{
        @strongify(self);
        [self selectAction:1];
    };
    [self.view addSubview:_femaleBtnView];
}

- (void)updateSelected:(NSInteger)sex
{
    [_maleBtnView setSelected:sex == 0];
    [_femaleBtnView setSelected:sex == 1];
}

@end

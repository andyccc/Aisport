//
//  NicknameViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "NicknameViewController.h"
#import "TitleFieldView.h"

@interface NicknameViewController ()
@property (nonatomic, strong) TitleFieldView *userField;
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation NicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"昵称";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F8F8F7"];
    
    [self createView];

}

- (void)addAction
{
    !self.finishBlock ?: self.finishBlock(_userField.textField.text);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView
{
    _userField = [[TitleFieldView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCR_WIDTH, uiv(78))];
    [_userField setTitle:@""];
    _userField.textField.left = _userField.titleLabel.left;
    _userField.textField.width = self.view.width  - _userField.titleLabel.left * 2;
    [_userField setPlaceholder:@"请输入"];
    [_userField setText:self.text];
    [self.view addSubview:_userField];
    
    _addBtn = [[UIButton alloc] init];
    _addBtn.width = uiv(306);
    _addBtn.height = uiv(44);
    _addBtn.backgroundColor = [UIColor colorWithHex:@"#FBB313"];
    [_addBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addBtn.titleLabel.font = FontBoldR(15);
    _addBtn.centerX = UIScreenWidth / 2.0;
    _addBtn.top = _userField.bottom + uiv(51);
    
    _addBtn.layer.cornerRadius = _addBtn.height/2.0;
    _addBtn.layer.masksToBounds = YES;

    
    [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
}

@end

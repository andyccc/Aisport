//
//  EditAddressViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "EditAddressViewController.h"
#import "TitleFieldView.h"
#import "TitleBtnView.h"
#import "TitleSwitchView.h"
#import "AreaSelectViewController.h"
#import "MineNetworkManager.h"

@interface EditAddressViewController ()
@property (nonatomic, strong) TitleFieldView *userField;
@property (nonatomic, strong) TitleFieldView *mobileField;
@property (nonatomic, strong) TitleBtnView *areaView;

@property (nonatomic, strong) TitleFieldView *addressField;
@property (nonatomic, strong) TitleSwitchView *switchView;
@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) id area1;
@property (nonatomic, strong) id area2;
@property (nonatomic, strong) id area3;


@property (nonatomic, strong) NSNumber *areaId1;
@property (nonatomic, strong) NSNumber *areaId2;
@property (nonatomic, strong) NSNumber *areaId3;
@property (nonatomic, strong) NSNumber *dataId;


@end

@implementation EditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加地址";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F8F8F7"];

    [self createView];
    [self loadData];
}

- (void)loadData
{
    if (self.data) {
        
        [self.userField setText:self.data[@"name"]];
        [self.mobileField setText:self.data[@"tel"]];
        NSString *area = [NSString stringWithFormat:@"%@%@%@",
                          self.data[@"provinceName"],
                          self.data[@"cityName"],
                          self.data[@"countyName"]
                          ];
        [self.areaView setText:area];
        [self.addressField setText:self.data[@"addressDetail"]];
        self.switchView.switcher.on = [self.data[@"isDefault"] intValue];
        
        self.areaId1 = self.data[@"province"];
        self.areaId2 = self.data[@"city"];
        self.areaId3 = self.data[@"county"];
        
        self.dataId = self.data[@"id"];
    }
}

- (void)addAddressAction
{   // 保存地址
    NSString *name = self.userField.textField.text;
    if ([name length] <= 0) {
        [SVProgressHUD showErrorWithStatus:@"收货人未填写"];
        return;
    }
    
    NSString *tel = self.mobileField.textField.text;
    if ([tel length] <= 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号未填写"];
        return;
    }

    if (!self.areaId1 &&!self.areaId2 && !self.areaId3) {
        [SVProgressHUD showErrorWithStatus:@"区域未选则"];
        return;
    }
    
    NSString *addressDetail = self.areaView.textField.text;
    if ([tel length] <= 0) {
        [SVProgressHUD showErrorWithStatus:@"详细地址未填写"];
        return;
    }
    
    int isDefault = self.switchView.switcher.on;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"isDefault"] = @(isDefault? 1: 0);
    params[@"name"] = name ? name : @"";
    params[@"tel"] = tel ? tel : @"";
    params[@"addressDetail"] = addressDetail ? addressDetail : @"";

    if (self.dataId) {
        params[@"id"] = self.dataId;
    }
    
    if (self.areaId1) {
        params[@"province"] = self.areaId1;
    }
    
    if (self.areaId2) {
        params[@"city"] = self.areaId2;
    }
    
    if (self.areaId3) {
        params[@"county"] = self.areaId3;
    }
    
    [self createOrUpdate:params];
    
}

- (void)createOrUpdate:(NSDictionary *)params
{
    [SVProgressHUD show];

    if (self.dataId) {
        [MineNetworkManager updateAddressWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [self andSuccessFn];
        } andFailerFn:^(NSError * _Nonnull error) {
            [self andFailerFn:error];
        }];
    } else {
        [MineNetworkManager createAddressWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [self andSuccessFn];
        } andFailerFn:^(NSError * _Nonnull error) {
            [self andFailerFn:error];
        }];
    }
}

- (void)andSuccessFn
{
    [SVProgressHUD dismiss];
    !self.editFinishBlock?: self.editFinishBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)andFailerFn:(NSError *)error
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];

}

- (void)areaAction
{
    // 选择区域
    AreaSelectViewController *vc = [AreaSelectViewController new];
    @weakify(self);
    vc.finishBlock = ^(id  _Nonnull data1, id  _Nonnull data2, id  _Nonnull data3) {
        @strongify(self);
        [self selectAreaFinish:data1 data2:data2 data3:data3];
    };
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)selectAreaFinish:(id)data1 data2:(id)data2 data3:(id)data3
{
    self.area1 = data1;
    self.area2 = data2;
    self.area3 = data3;
    
    NSMutableString *area = [NSMutableString string];
    NSString *name = @"";
    if (data1 && (name = data1[@"name"])) {
        [area appendString:name];
        self.areaId1 = data1[@"id"];
    } else {
        self.areaId1 = nil;
    }
    
    if (data2 && (name = data2[@"name"])) {
        [area appendString:name];
        self.areaId2 = data2[@"id"];
    } else {
        self.areaId2 = nil;
    }
    
    if (data3 && (name = data3[@"name"])) {
        [area appendString:name];
        self.areaId3 = data3[@"id"];
    } else {
        self.areaId3 = nil;
    }
    
    [_areaView setText:area];
}

- (void)createView
{
    _userField = [[TitleFieldView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCR_WIDTH, uiv(78))];
    [_userField setTitle:@"收货人"];
    [_userField setPlaceholder:@"应快递实名制规则，请填写收货人真实姓名"];
    [self.view addSubview:_userField];
    
    
    _mobileField = [[TitleFieldView alloc] initWithFrame:CGRectMake(0, _userField.bottom, SCR_WIDTH, uiv(78))];
    [_mobileField setTitle:@"手机号"];
    [_mobileField setPlaceholder:@"请填写您的手机号"];
    _mobileField.textField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_mobileField];

    
    _areaView = [[TitleBtnView alloc] initWithFrame:CGRectMake(0, _mobileField.bottom, SCR_WIDTH, uiv(78))];
    [_areaView setTitle:@"选择区域"];
    [_areaView setPlaceholder:@"选择地区"];
    @weakify(self);
    _areaView.btnBlock = ^{
        @strongify(self);
        [self areaAction];
    };
    [self.view addSubview:_areaView];

    _addressField = [[TitleFieldView alloc] initWithFrame:CGRectMake(0, _areaView.bottom, SCR_WIDTH, uiv(78))];
    [_addressField setTitle:@"详细地址"];
    [_addressField setPlaceholder:@"请填写详细地址"];
    _addressField.lineView.hidden = YES;
    [self.view addSubview:_addressField];

    _switchView = [[TitleSwitchView alloc] initWithFrame:CGRectMake(0, _addressField.bottom + uiv(12), SCR_WIDTH, uiv(62))];
    [_switchView setTitle:@"设为默认地址"];
    _switchView.lineView.hidden = YES;
    [self.view addSubview:_switchView];

    
    _addBtn = [[UIButton alloc] init];
    _addBtn.width = uiv(306);
    _addBtn.height = uiv(44);
    _addBtn.backgroundColor = [UIColor colorWithHex:@"#FBB313"];
    [_addBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addBtn.titleLabel.font = FontBoldR(15);
    _addBtn.centerX = UIScreenWidth / 2.0;
    _addBtn.top = _switchView.bottom + uiv(32);
    
    _addBtn.layer.cornerRadius = _addBtn.height/2.0;
    _addBtn.layer.masksToBounds = YES;

    
    [_addBtn addTarget:self action:@selector(addAddressAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
}


@end

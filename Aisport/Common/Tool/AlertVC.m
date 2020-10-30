//
//  AlertVC.m
//  NeoPay
//
//  Created by adminn on 2017/7/7.
//  Copyright © 2017年 Jesus. All rights reserved.
//

#import "AlertVC.h"

@interface AlertVC ()

@end

@implementation AlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(instancetype)initWithType:(int)type andTitle:(NSString *)title andMessage:(NSString *)msg and:(NSArray *)otherBtn and:(otherBlock)otherBlock
{
    self = [super init];
    if(self)
    {
        self = (AlertVC*)[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:type];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [self addAction:cancelAction];
        
        for(int i=0;i<otherBtn.count;i++)
        {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:otherBtn[i] style:UIAlertActionStyleDefault handler:otherBlock];
            [self addAction:okAction];
        }
    }
    return self;
}

-(instancetype)initWithType:(int)type andTitle:(NSString*)title andMessage:(NSString*)msg and:(NSString*)cancelTitle and:(NSArray*)otherBtn and:(otherBlock)otherBlock
{
    self = [super init];
    if(self)
    {
        self = (AlertVC*)[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:type];
        
        if(cancelTitle != nil)
        {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
            [self addAction:cancelAction];
        }
        
        for(int i=0;i<otherBtn.count;i++)
        {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:otherBtn[i] style:UIAlertActionStyleDefault handler:otherBlock];
            [self addAction:okAction];
        }
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

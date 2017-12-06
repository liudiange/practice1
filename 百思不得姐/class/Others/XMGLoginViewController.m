//
//  XMGLoginViewController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/8/30.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGLoginViewController.h"

@interface XMGLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextAccountField;
@property (weak, nonatomic) IBOutlet UITextField *loginPassTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UITextField *registAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *registPassTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftContraton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewRightConstaton;
@property (weak, nonatomic) IBOutlet UIButton *loginOrRegistButton;



@end

@implementation XMGLoginViewController
- (void)awakeFromNib {
    [super awakeFromNib];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = XMG_BACKGROUND_COLOR;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 事件的响应

/**
 *
 *  返回的事件
 */
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *
 *  注册和登录的事件
 */
- (IBAction)loginOrRegistAction:(UIButton *)sender {
    if (self.loginViewLeftContraton.constant == 0) {
       
        self.loginViewLeftContraton.constant = -[UIScreen mainScreen].bounds.size.width;
        self.loginViewRightConstaton.constant = [UIScreen mainScreen].bounds.size.width;
        self.loginOrRegistButton.selected = NO;
    }else {
        self.loginViewLeftContraton.constant = 0;
        self.loginViewRightConstaton.constant = 0;
        self.loginOrRegistButton.selected = YES;
    }
     [UIView animateWithDuration:0.25 animations:^{
         [self.view layoutIfNeeded];
     }];
}
@end

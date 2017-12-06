//
//  XMGFellowViewController.m
//  百思不得姐
//
//  Created by Connect on 2017/8/2.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGFellowViewController.h"
#import "XMGLoginViewController.h"

@interface XMGFellowViewController ()

@end

@implementation XMGFellowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XMG_BACKGROUND_COLOR;
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButton:self imageName:@"bottom_contact_unselect" selectImageName:@"bottom_contact_unselect" action:@selector(fellowAction:)];
    
}
- (void)fellowAction:(UIButton *)button {
   

}
- (IBAction)loginAction:(UIButton *)sender {
    
    XMGLoginViewController *loginVc = [[XMGLoginViewController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
}


@end

//
//  XMGNewPostTestViewController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/11.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGNewPostTestViewController.h"
#import "XMGBaseTextView.h"

@interface XMGNewPostTestViewController ()

@property (weak, nonatomic) IBOutlet XMGBaseTextView *textView;

@end

@implementation XMGNewPostTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.textView.xmg_placeHolderColor = [UIColor redColor];
    self.textView.xmg_placeHolder = @"撒打算打算的那是大叔的";
    
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

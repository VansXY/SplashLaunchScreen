//
//  SecondViewController.m
//  SplashLaunchScreenVC
//
//  Created by 肖扬 on 2018/5/31.
//  Copyright © 2018年 Vickate. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

/** button */
@property (nonatomic, strong) UIButton *button;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addButton];
}

- (void)addButton {
    _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button.frame = CGRectMake(15, 650, 345, 50);
    _button.backgroundColor = [UIColor purpleColor];
    _button.alpha = 0.5;
    [_button setTitle:@"登录" forState:(UIControlStateNormal)];
    [_button addTarget:self action:@selector(dismissVC) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
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

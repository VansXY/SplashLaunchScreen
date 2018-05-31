//
//  ViewController.m
//  SplashLaunchScreenVC
//
//  Created by 肖扬 on 2018/5/30.
//  Copyright © 2018年 Vickate. All rights reserved.
//

#import "ViewController.h"
#import "SplashViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

/** splashVC */
@property (nonatomic, strong) SplashViewController *splashVC;
/** button */
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self displayMovie];
    [self addButton];
}

- (void)displayMovie {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    
    if (!path.length) {
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:path];
    self.splashVC = [[SplashViewController alloc] init];
    self.splashVC.videoFrame = [UIScreen mainScreen].bounds;
    self.splashVC.scalingFillMode = Scaling_resizeAspectFill;
    self.splashVC.alwaysRepeat = YES;
    self.splashVC.sound = YES;
    self.splashVC.startTime = 12.0;
    self.splashVC.duration = 4.0;
    self.splashVC.alpha = 0.7;
    self.splashVC.backgroundColor = UIColor.whiteColor;
    self.splashVC.contentURL = url;
    [self.view addSubview:self.splashVC.view];
    
}

- (void)addButton {
    _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button.frame = CGRectMake(15, 650, 345, 50);
    _button.backgroundColor = [UIColor purpleColor];
    _button.alpha = 0.5;
    [_button setTitle:@"登录" forState:(UIControlStateNormal)];
    [_button addTarget:self action:@selector(pushVC) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
}

- (void)pushVC {
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

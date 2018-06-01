//
//  SecondViewController.m
//  SplashLaunchScreenVC
//
//  Created by 肖扬 on 2018/5/31.
//  Copyright © 2018年 Vickate. All rights reserved.
//

#import "SecondViewController.h"
#import "CropVideoTool.h"
#import "CoverAnimation.h"
#import "SplashViewController.h"

@interface SecondViewController ()

/** button */
@property (nonatomic, strong) UIButton *button;
/** imageView */
@property (nonatomic, strong) UIImageView *imageView;
/** splashVC */
@property (nonatomic, strong) SplashViewController *splashVC;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addButton];
    [self showFirstImage];
}

- (void)showFirstImage {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    if (!path.length) {return;}
    NSURL *url = [NSURL fileURLWithPath:path];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 84, 275, 275)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [[CropVideoTool new] firstImageWithVideoUrl:url];
    [self.view addSubview:_imageView];
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
    self.transitioningDelegate = self;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    CoverAnimation *animation = [CoverAnimation new];
    animation.isPush = NO;
    return animation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

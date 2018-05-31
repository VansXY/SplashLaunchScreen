//
//  SplashViewController.h
//  SplashLaunchScreenVC
//
//  Created by 肖扬 on 2018/5/30.
//  Copyright © 2018年 Vickate. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ScalingMode) {
    Scaling_resize,
    Scaling_resizeAspect,
    Scaling_resizeAspectFill,
};

@interface SplashViewController : UIViewController

/** CGRect */
@property (nonatomic, assign) CGRect videoFrame;
/** startTime */
@property (nonatomic, assign) CGFloat startTime;
/** duration */
@property (nonatomic, assign) CGFloat duration;
/** alpha */
@property (nonatomic, assign) CGFloat alpha;
/** backgroundColor */
@property (nonatomic, strong) UIColor *backgroundColor;
/** contentURL */
@property (nonatomic, strong) NSURL *contentURL;
/** sound */
@property (nonatomic, assign) BOOL sound;
/** alwaysRepeat */
@property (nonatomic, assign) BOOL alwaysRepeat;
/** fillMode */
@property (nonatomic, assign) ScalingMode scalingFillMode;

- (void)isRestartForeground:(BOOL)isRestart;

- (void)playVideo;

- (void)pausevideo;

@end

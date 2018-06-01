//
//  CoverAnimation.h
//  SplashLaunchScreenVC
//
//  Created by HXB-xiaoYang on 2018/6/1.
//Copyright © 2018年 Vickate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^willEndInteractiveBlock)(BOOL isSuccess);

@interface CoverAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPush;

@property (nonatomic, copy) willEndInteractiveBlock block;



- (void)pushNextVCWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)popBackVCWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;


@end

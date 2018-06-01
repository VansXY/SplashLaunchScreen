//
//  CoverAnimation.m
//  SplashLaunchScreenVC
//
//  Created by HXB-xiaoYang on 2018/6/1.
//Copyright © 2018年 Vickate. All rights reserved.
//

#import "CoverAnimation.h"

static NSTimeInterval timeInterval = 1;

@implementation CoverAnimation

- (void)pushNextVCWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containView = [transitionContext containerView];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    
    [containView addSubview:fromVC.view];
    [containView addSubview:toVC.view];
    [containView addSubview:tempView];
    
    fromVC.view.hidden = YES;
    toVC.view.hidden = NO;
    toVC.view.alpha = 1;
    tempView.hidden = NO;
    tempView.alpha = 1;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:timeInterval animations:^{
            tempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
            tempView.alpha = 0.1;
            
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                toVC.view.hidden = NO;
                [transitionContext completeTransition:NO];
            } else {
                toVC.view.hidden = NO;
                [transitionContext completeTransition:YES];
            }
            [tempView removeFromSuperview];
        }];
    });
}

- (void)popBackVCWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containView = [transitionContext containerView];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    
    [containView addSubview:fromVC.view];
    [containView addSubview:toVC.view];
    [containView addSubview:tempView];
    
    fromVC.view.hidden = YES;
    toVC.view.hidden = NO;
    toVC.view.alpha = 1;
    tempView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:timeInterval animations:^{
            tempView.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);
            tempView.alpha = 0.1;
        } completion:^(BOOL finished) {
            
            if ([transitionContext transitionWasCancelled]) {
                fromVC.view.hidden = NO;
                tempView.alpha = 1;
                [transitionContext completeTransition:NO];
            } else {
                toVC.view.hidden = NO;
                [transitionContext completeTransition:YES];
            }
            [tempView removeFromSuperview];
        }];
    });
    

    __weak UIViewController * weakToVC = toVC;
    __weak UIViewController * weakFromVC = fromVC;

    self.block = ^(BOOL isSuccess) {
        if (isSuccess) {
            weakToVC.view.hidden = NO;
            [tempView removeFromSuperview];
        } else {
            weakFromVC.view.hidden = NO;
            tempView.alpha = 1;
        }
    };

}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return timeInterval;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPush) {
        [self pushNextVCWithContext:transitionContext];
    } else {
        [self popBackVCWithContext:transitionContext];
    }
}


@end

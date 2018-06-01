//
//  XYPlayerView.h
//  SplashLaunchScreenVC
//
//  Created by HXB-xiaoYang on 2018/6/1.
//Copyright © 2018年 Vickate. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MP4URL @"http://221.228.226.23/11/t/j/v/b/tjvbwspwhqdmgouolposcsfafpedmb/sh.yinyuetai.com/691201536EE4912BF7E4F1E2C67B8119.mp4"

@interface XYPlayerView : UIView

/// 是否重复播放
@property (nonatomic, assign) BOOL isRepeat;
/// 是否展示取消按钮
@property (nonatomic, assign) BOOL isShowBackButton;

@end

//
//  CropVideoTool.h
//  SplashLaunchScreenVC
//
//  Created by 肖扬 on 2018/5/31.
//  Copyright © 2018年 Vickate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^completion)(NSURL *videoPath);

@interface CropVideoTool : NSObject


/**
 截取视频

 @param url 视频的url或者本地链接
 @param startTime 截取的起始时间
 @param videoDuration 截取的长度
 @param completion 完成过后的回调
 */
- (void)cropVideoWithVideoUrl:(NSURL *)url
                    startTime:(CGFloat)startTime
                videoDuration:(CGFloat)videoDuration
                   completion:(completion)completion;


/**
 获取视频第一帧图片

 @param url 视频的url或者本地链接
 */
- (UIImage *)firstImageWithVideoUrl:(NSURL *)url;


@end

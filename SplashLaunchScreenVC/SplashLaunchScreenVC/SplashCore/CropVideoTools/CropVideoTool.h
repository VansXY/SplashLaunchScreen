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

/** videoPath */
@property (nonatomic, strong) NSURL *videoPath;

- (void)cropVideoWithVideoUrl:(NSURL *)url
                    startTime:(CGFloat)startTime
                videoDuration:(CGFloat)videoDuration
                   completion:(completion)completion;


@end

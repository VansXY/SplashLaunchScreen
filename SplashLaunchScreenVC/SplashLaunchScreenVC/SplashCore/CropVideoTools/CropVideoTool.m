//
//  CropVideoTool.m
//  SplashLaunchScreenVC
//
//  Created by 肖扬 on 2018/5/31.
//  Copyright © 2018年 Vickate. All rights reserved.
//

#import "CropVideoTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation CropVideoTool

- (void)cropVideoWithVideoUrl:(NSURL *)url startTime:(CGFloat)startTime videoDuration:(CGFloat)videoDuration completion:(completion)completion {
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    
    CMTime start = CMTimeMakeWithSeconds(startTime, 10);
    CMTime duration = CMTimeMakeWithSeconds(videoDuration, 10);
    CMTimeRange range = CMTimeRangeMake(start, duration);
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetHighestQuality];
    
    NSString *outputFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"output.mp4"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:outputFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:outputFilePath error:nil];
    }
    
    [[NSFileManager defaultManager] createDirectoryAtPath:NSTemporaryDirectory() withIntermediateDirectories:YES attributes:nil error:nil];
    
    
    NSURL *outputFile = [NSURL fileURLWithPath:outputFilePath];
    
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
    exportSession.outputURL = outputFile;
    exportSession.timeRange = range;
    exportSession.shouldOptimizeForNetworkUse = YES;
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        if (completion) {
            completion(exportSession.outputURL);
        }
    }];
}


@end

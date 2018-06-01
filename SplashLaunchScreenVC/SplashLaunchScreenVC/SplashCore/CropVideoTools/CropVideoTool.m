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

- (UIImage *)firstImageWithVideoUrl:(NSURL *)url {
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:options];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    CGImageRef imageRef = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:nil];
    if (imageRef) {
        UIImage *firstImage = [[UIImage alloc] initWithCGImage:imageRef scale:1 orientation:(UIImageOrientationUp)];
        return firstImage;
    }
    return nil;
}



@end

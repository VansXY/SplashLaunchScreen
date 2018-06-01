//
//  XYPlayerLayer.m
//  SplashLaunchScreenVC
//
//  Created by HXB-xiaoYang on 2018/6/1.
//Copyright © 2018年 Vickate. All rights reserved.
//

#import "XYPlayerLayer.h"

@implementation XYPlayerLayer

- (instancetype)initWithFrame:(CGRect)frame url:(NSURL *)url{
    if (self = [super init]) {
        self.frame = frame;
        [self displayPlayerLayerWithUrl:url];
    }
    return self;
}

- (void)displayPlayerLayerWithUrl:(NSURL *)url {
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:MP4URL]];
    //添加监听
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    //设置模式
    self.videoGravity = AVLayerVideoGravityResizeAspectFill;
    

}

//监听回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    } else if ([keyPath isEqualToString:@"status"]) {
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            NSLog(@"playerItem is ready");
            [self.player play];
        } else {
            NSLog(@"load break");
        }
    }
}

- (void)playVideo {
    [self.player play];
}

- (void)pauseVideo {
    
}

- (void)replayVideo {
    
}

- (void)dealloc {
    
}

@end

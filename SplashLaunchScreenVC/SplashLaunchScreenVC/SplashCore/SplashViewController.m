//
//  SplashViewController.m
//  SplashLaunchScreenVC
//
//  Created by 肖扬 on 2018/5/30.
//  Copyright © 2018年 Vickate. All rights reserved.
//

#import "SplashViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "CropVideoTool.h"

@interface SplashViewController ()

/** moviePlayer */
@property (nonatomic, strong) AVPlayerViewController *moviePlayer;
/** moviePlayerSoundLevel */
@property (nonatomic, assign) float moviePlayerSoundLevel;
/** tools */
@property (nonatomic, strong) CropVideoTool *tools;
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)init {
    if (self = [super init]) {
        self.moviePlayerSoundLevel = 1.0;
        _moviePlayer = [[AVPlayerViewController alloc] init];
        _moviePlayer.showsPlaybackControls = NO;
        [_moviePlayer.view setUserInteractionEnabled:NO];
        
        [self.view addSubview:_moviePlayer.view];
    }
    return self;
}


- (void)setMoviePlayerWithUrl:(NSURL *)url {
    _tools = [[CropVideoTool alloc] init];
    [_tools cropVideoWithVideoUrl:url startTime:_startTime videoDuration:_duration completion:^(NSURL *videoPath) {
        [self videoPathWith:videoPath?: url];
    }];
}

- (void)videoPathWith:(NSURL *)videoPath {
    if (!videoPath) {
        return ;
    }
    self.moviePlayer.player = [AVPlayer playerWithURL:videoPath];
    [self.moviePlayer.player addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil];
    [self.moviePlayer.player play];
    self.moviePlayer.player.volume = self.moviePlayerSoundLevel;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    AVPlayer *player;
    if ([object isKindOfClass:[AVPlayer class]]) {
        player = object;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }

    if (player.status == AVPlayerStatusReadyToPlay) {
    }
}

- (void)playerItemDidReachEnd {
    [self.moviePlayer.player seekToTime:kCMTimeZero];
    [self.moviePlayer.player play];
}

- (void)playVideo {
    [self.moviePlayer.player play];
}

- (void)pausevideo {
    [self.moviePlayer.player pause];
}

- (void)isRestartForeground:(BOOL)isRestart {
    if (isRestart) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
}

- (void)setAlwaysRepeat:(BOOL)alwaysRepeat {
    _alwaysRepeat = alwaysRepeat;
    if (_alwaysRepeat) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.view.backgroundColor = _backgroundColor;
}

- (void)setContentURL:(NSURL *)contentURL {
    _contentURL = contentURL;
    if (_contentURL) {
        [self setMoviePlayerWithUrl:_contentURL];
    }
}

- (void)setSound:(BOOL)sound {
    _sound = sound;
    _moviePlayerSoundLevel = _sound ? 1:0;
}

- (void)setAlpha:(CGFloat)alpha {
    _alpha = alpha;
    self.moviePlayer.view.alpha = _alpha;
}

- (void)setScalingFillMode:(ScalingMode)scalingFillMode {
    switch (scalingFillMode) {
        case Scaling_resize:
            self.moviePlayer.videoGravity = AVLayerVideoGravityResize;
            
        case Scaling_resizeAspect:
            self.moviePlayer.videoGravity = AVLayerVideoGravityResizeAspect;
            
        case Scaling_resizeAspectFill:
            self.moviePlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
}

- (void)setVideoFrame:(CGRect)videoFrame {
    _videoFrame = videoFrame;
    _moviePlayer.view.frame = _videoFrame;
}

- (void)dealloc {
    [self.moviePlayer.player removeObserver:self forKeyPath:@"status" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end

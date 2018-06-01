//
//  XYPlayerView.m
//  SplashLaunchScreenVC
//
//  Created by HXB-xiaoYang on 2018/6/1.
//Copyright © 2018年 Vickate. All rights reserved.
//

#import "XYPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface XYPlayerView ()

@property (nonatomic, strong) AVPlayer *player;             // 播放器
@property (nonatomic, strong) AVPlayerItem *item;           // 播放单元
@property (nonatomic, strong) AVPlayerLayer *playerLayer;   // 播放界面（layer）

@property (nonatomic, assign) NSTimeInterval current;       // 视频当前的播放进度
@property (nonatomic, assign) NSTimeInterval total;         // 视频的总长度

@property (nonatomic, strong) UIView *headerView;           // 视频当前的播放进度
@property (nonatomic, strong) UIView *bottomView;           // 视频的总长度

@property (nonatomic, strong) CADisplayLink *displayLink;   // displayLink

@end

@implementation XYPlayerView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:MP4URL]];
        self.player = [AVPlayer playerWithPlayerItem:self.item];
        
        //添加监听
        [self.item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.playerLayer.contentsScale = 1;
        self.playerLayer.frame = CGRectMake(0, 0, 375, 200);
        [self.layer addSublayer:self.playerLayer];

    }
    return self;
}

#pragma mark --- UI
- (void)addHeaderTool {
//    self.topView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.topView.backgroundColor = [UIColor blackColor];
//    self.topView.alpha = .5;
//    [self.view addSubview:self.topView];
//
//    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.top.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.height.mas_equalTo(60);
//    }];
//
//    //返回按钮
//    self.backButton = [[UIButton alloc] initWithFrame:CGRectZero];
//    [self.backButton setImage:[UIImage imageNamed:@"gobackBtn"] forState:UIControlStateNormal];
//    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.topView addSubview:self.backButton];
//
//    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.topView).offset(10);
//        make.top.equalTo(self.topView).offset(10);
//        make.bottom.equalTo(self.topView).offset(-10);
//        make.width.mas_equalTo(self.backButton.mas_height);
//    }];
//
//    //标题
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    self.titleLabel.backgroundColor = [UIColor clearColor];
//    self.titleLabel.textColor = [UIColor whiteColor];
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.text = self.videoModel.name;
//    [self.topView addSubview:self.titleLabel];
//
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.topView);
//        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 100, 40));
//    }];
}

- (void)addBottomTool {
//    self.bottmView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.bottmView.backgroundColor = [UIColor blackColor];
//    self.bottmView.alpha = .5;
//    [self.view addSubview:self.bottmView];
//
//    [self.bottmView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view);
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.height.mas_equalTo(60);
//    }];
//
//    //播放按钮
//    self.playButton = [[UIButton alloc] initWithFrame:CGRectZero];
//    [self.playButton setImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
//    [self.playButton setImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateSelected];
//    [self.playButton addTarget:self action:@selector(playOrPauseAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.playButton.enabled = NO;
//    [self.bottmView addSubview:self.playButton];
//
//    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.bottmView).offset(10);
//        make.top.equalTo(self.bottmView).offset(10);
//        make.bottom.equalTo(self.bottmView).offset(-10);
//        make.width.mas_equalTo(self.backButton.mas_height);
//    }];
//
//    //时间
//    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    self.timeLabel.text = @"00:00:00/00:00:00";
//    self.timeLabel.textColor = [UIColor whiteColor];
//    self.timeLabel.textAlignment = NSTextAlignmentRight;
//    [self.bottmView addSubview:self.timeLabel];
//    CGSize size = CGSizeMake(1000,10000);
//    //计算实际frame大小，并将label的frame变成实际大小
//    NSDictionary *attribute = @{NSFontAttributeName:self.timeLabel.font};
//    CGSize labelsize = [self.timeLabel.text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.bottmView).offset(-10);
//        make.top.equalTo(self.bottmView).offset(10);
//        make.bottom.equalTo(self.bottmView).offset(-10);
//        make.width.mas_equalTo(labelsize.width + 5);
//    }];
//
//    //滑块
//    self.slider = [[AC_ProgressSlider alloc] initWithFrame:CGRectZero direction:AC_SliderDirectionHorizonal];
//    [self.bottmView addSubview:self.slider];
//    self.slider.enabled = NO;
//
//    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.playButton.mas_right).offset(10);
//        make.right.equalTo(self.timeLabel.mas_left).offset(-10);
//        make.height.mas_equalTo(40);
//        make.centerY.equalTo(self.bottmView);
//    }];
//
//
//    [self.slider addTarget:self action:@selector(progressValueChange:) forControlEvents:UIControlEventValueChanged];
}

//更新方法
- (void)upadte {
//    NSTimeInterval current = CMTimeGetSeconds(self.avPlayer.currentTime);
//    NSTimeInterval total = CMTimeGetSeconds(self.avPlayer.currentItem.duration);
//    //如果用户在手动滑动滑块，则不对滑块的进度进行设置重绘
//    if (!self.slider.isSliding) {
//        self.slider.sliderPercent = current/total;
//    }
//
//    if (current!=self.lastTime) {
//        [self.activity stopAnimating];
//        self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", [self formatPlayTime:current], isnan(total)?@"00:00:00":[self formatPlayTime:total]];
//    }else{
//        [self.activity startAnimating];
//    }
//    self.lastTime = current;
    
}


#pragma mark ----

/// 获取视频当前的缓冲进度
- (NSTimeInterval)availableDurationWithplayerItem:(AVPlayerItem *)playerItem {
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);
    NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

/// 将时间转换成00:00:00格式
- (NSString *)formatPlayTime:(NSTimeInterval)duration {
    int minute = 0, hour = 0, secend = duration;
    minute = (secend % 3600) / 60;
    hour = secend / 3600;
    secend = secend % 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, secend];
}



#pragma mark - UI

// 监听回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    } else if ([keyPath isEqualToString:@"status"]) {
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            [self.player play];
        } else {
            
        }
    }
}

// 根据屏幕帧数刷新
- (void)startTranstionAnimation {
    
}

- (void)setIsRepeat:(BOOL)isRepeat{
    _isRepeat = isRepeat;
    if (_isRepeat) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
}

- (void)playerItemDidReachEnd {
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

//视频播放完成
- (void)moviePlayDidEnd {
    NSLog(@"播放完成");
    
//    NSInteger index = [self.videoArr indexOfObject:self.videoModel];
//    if (index!= self.videoArr.count-1) {
//        [self.avPlayer pause];
//        self.videoModel = self.videoArr[index + 1];
//        [self changeCurrentplayerItemWithAC_VideoModel:self.videoModel];
//    }else{
//        [self.avPlayer pause];
//        [self.link invalidate];
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showOrHideBar];
}

- (void)showOrHideBar {
//    if (!self.isHidenListView) {
//        self.isHidenListView = YES;
//        self.listTableView.hidden = YES;
//        [self.listTableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.view).offset(300);
//        }];
//    }
//    [UIView animateWithDuration:.3 animations:^{
//        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//
//        [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view).offset(self.isHidenTabView?0:-60);
//        }];
//
//        [self.bottmView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view).offset(self.isHidenTabView?0:60);
//        }];
//
//
//        [self.view layoutIfNeeded];
//    } completion:^(BOOL finished) {
//        self.isHidenTabView = !self.isHidenTabView;
//        self.listTableView.hidden = NO;
//    }];
    
}

#pragma mark - rotate control
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.item removeObserver:self forKeyPath:@"status"];
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(startTranstionAnimation)];
    }
    return _displayLink;
}


@end

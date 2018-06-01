# SplashLaunchScreen

### SplashCore 引导页动画

```
NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    
    if (!path.length) {
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:path];
    self.splashVC = [[SplashViewController alloc] init];
    self.splashVC.videoFrame = [UIScreen mainScreen].bounds;
    self.splashVC.scalingFillMode = Scaling_resizeAspectFill;
    self.splashVC.alwaysRepeat = YES;
    self.splashVC.sound = YES;
    self.splashVC.startTime = 12.0;
    self.splashVC.duration = 4.0;
    self.splashVC.alpha = 0.7;
    self.splashVC.backgroundColor = UIColor.whiteColor;
    self.splashVC.contentURL = url;
    [self.view addSubview:self.splashVC.view];
```

![image](https://github.com/VansXY/MyFirstDemo/blob/master/MyFirst/MyFirst/gif5%E6%96%B0%E6%96%87%E4%BB%B6.gif)


### TransitionCore 转场动画
效果如下：

![image](https://github.com/VansXY/MyFirstDemo/blob/master/gif5%E6%96%B0%E6%96%87%E4%BB%B6%20(1).gif)



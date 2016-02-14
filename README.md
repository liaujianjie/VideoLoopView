# VideoLoopView
A simple UIView subclass that loops a video written in Swift, useful for videos on onboarding implementations. Start using with only two or three lines of code!

## Installation

**Carthage**
```
github "liaujianjie/VideoLoopView" ~> 1.1
```

**CocoaPods**
```
pod 'VideoLoopView', '~> 1.1'
```

## Usage

### Example 1: Using Storyboards
**Swift**
```
self.videoView.videoUrl = NSBundle.mainBundle().URLForResource("samplevideo.mov", withExtension: nil)
```
**Objective-C**
```
self.videoView.videoUrl = [[NSBundle mainBundle] URLForResource:@"samplevideo.mov" withExtension:nil];
```

### Example 2: Create with Code
**Swift**
```
let videoUrl = NSBundle.mainBundle().URLForResource("samplevideo.mov", withExtension: nil)
var videoView = VideoLoopView.init(videoUrl: videoUrl!)
```
**Objective-C**
```
NSURL *videoUrl = [[NSBundle mainBundle] URLForResource:@"samplevideo.mov" withExtension:nil];
VideoLoopView *videoView = [[VideoLoopView alloc] initWithVideoUrl:videoUrl];
```

### Other properties
* `muted` - mutes/unmutes the video, muted by default
* For others, see [VideoLoopView.swift](VideoLoopView/VideoLoopView/VideoLoopView.swift)

## Author
Written by [Liau Jian Jie](https://twitter.com/jianjie_).


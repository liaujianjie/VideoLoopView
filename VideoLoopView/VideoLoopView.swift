//
//  VideoLoopView.swift
//  VideoLoopView
//
//  Created by Jian Jie on 14/2/16.
//  Copyright © 2016 Liau Jian Jie. All rights reserved.
//

import UIKit
import AVFoundation

public class VideoLoopView: UIView {
    public var videoUrl: NSURL? {
        didSet {
            if let _ = videoUrl {
                self.playerItem = AVPlayerItem.init(URL: self.videoUrl!)
            }
        }
    }
    @IBInspectable public var muted: Bool = true {
        didSet {
            self.player?.muted = self.muted
        }
    }
    public var player: AVPlayer?
    public var playerItem: AVPlayerItem? {
        didSet {
            if let playerItem = self.playerItem {
                self.player = AVPlayer.init(playerItem: playerItem)
                self.player!.actionAtItemEnd = .None
                self.player!.muted = self.muted
                NSNotificationCenter.defaultCenter().removeObserver(self)
                NSNotificationCenter.defaultCenter().addObserver(self,
                    selector: "playerItemDidReachEnd:",
                    name: AVPlayerItemDidPlayToEndTimeNotification,
                    object: playerItem)
                self.playerLayer.player = self.player
                self.player!.play()
                self.layoutSubviews()
            }
        }
    }
    public let playerLayer: AVPlayerLayer = AVPlayerLayer.init()
    
    // MARK:- View Lifecycle
    
    override public init(frame: CGRect) {
        super.init(frame: frame);
        
        {
            self.setup()
        }()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        {
            self.setup()
        }()
    }
    
    public init(videoUrl: NSURL) {
        self.init();
        
        {
            self.videoUrl = videoUrl;
        }()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // update AVPlayerLayer frame when VideoLoopView has been resized
        var newFrame = self.frame
        newFrame.origin = CGPointZero
        self.playerLayer.frame = newFrame
        self.playerLayer.removeFromSuperlayer()
        self.layer.addSublayer(self.playerLayer)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func setup() {
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    }
    
    // MARK:- Controls
    
    @objc public func playVideo() {
        self.player?.play()
    }
    
    @objc public func pauseVideo() {
        self.player?.pause()
    }
    
    // MARK:- NSNotification
    
    func playerItemDidReachEnd(notification: NSNotification) {
        let playerItem = notification.object as! AVPlayerItem
        playerItem.seekToTime(kCMTimeZero)
    }
}

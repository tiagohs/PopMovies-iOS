//
//  VideoViewerController.swift
//  popmovies
//
//  Created by Tiago Silva on 23/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero
import YoutubePlayer_in_WKWebView

class VideoViewerController: BaseViewController {
    
    @IBOutlet weak var videoView: WKYTPlayerView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var panGesture: UIPanGestureRecognizer!

    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let video = self.video, let key = video.key {
            videoView.hero.id = video.id
            videoView.hero.modifiers = [.useNoSnapshot]
            
            videoView.load(withVideoId: key)
        }
        
        containerView.addGestureRecognizer(panGesture)
        videoView.addGestureRecognizer(panGesture)
        videoView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        videoView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width / 16 * 9)
        videoView.center = view.center
    }
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: nil)
        let progress = translation.y / view.bounds.height
        
        switch panGesture.state {
        case .began:
            dismiss()
        case .changed:
            Hero.shared.update(progress)
            
            let currentPos = CGPoint(x: translation.x + view.center.x, y: translation.y + view.center.y)
            
            Hero.shared.apply(
                modifiers: [
                    .position(currentPos)
                ],
                to: videoView)
        default:
            if progress + panGesture.velocity(in: nil).y / view.bounds.height > 0.3 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    @IBAction func dismiss() {
        hero.dismissViewController()
    }
}

extension VideoViewerController: WKYTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
}

extension VideoViewerController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let v = panGesture.velocity(in: nil)
        
        return v.y > abs(v.x)
    }
}

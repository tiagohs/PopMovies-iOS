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

// MARK: VideoViewerController: BaseViewController

class VideoViewerController: BaseViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var videoView: WKYTPlayerView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var panGesture: UIPanGestureRecognizer!

    // MARK: Properties
    
    var presenter: VideoViewerPresenterInterface?
}

// MARK: Lifecycle Methods

extension VideoViewerController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter?.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        presenter?.viewWillLayoutSubviews()
    }
}

// MARK: WKYTPlayerViewDelegate

extension VideoViewerController: WKYTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
}

// MARK: UIGestureRecognizerDelegate

extension VideoViewerController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let v = panGesture.velocity(in: nil)
        
        return v.y > abs(v.x)
    }
}

// MARK: VideoViewerViewInterface

extension VideoViewerController: VideoViewerViewInterface {
    
    func setupUI() {
        backButton.layer.cornerRadius = backButton.bounds.width / 2
        shareButton.layer.cornerRadius = shareButton.bounds.width / 2
        
        containerView.addGestureRecognizer(panGesture)
        videoView.addGestureRecognizer(panGesture)
        
        videoView.delegate = self
    }
    
    func setupVideoFrame() {
        videoView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width / 16 * 9)
        videoView.center = view.center
    }
    
    func setupVideoVewer(with youtubeKey: String, _ videoID: String) {
        videoView.hero.id = videoID
        videoView.hero.modifiers = [.useNoSnapshot]
        
        videoView.load(withVideoId: youtubeKey)
    }
}

// MARK: Actions Methods

private extension VideoViewerController {
    
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

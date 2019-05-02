//
//  TabCell.swift
//  popmovies
//
//  Created by Tiago Silva on 23/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailsContentCell: UITableViewCell, WormTabStripDelegate {
    
    let overviewViewControllerIdentifier = "OverviewViewControllerIdentifier"
    let midiaViewControllerIdentifier = "MidiaViewControllerIdentifier"
    
    var tabs: [UIViewController] = []
    
    @IBOutlet weak var contentUIView: UIView!
    var isConfigurate = false
    
    var viewPager: WormTabStrip?
    var tabBarCallback: TabBarCallback?
    
    var overviewViewController: OverviewViewController?
    var midiaViewController: MidiaViewController?
    
    var movie: Movie? {
        didSet {
            if let overviewTabController = self.overviewViewController, let midiaTabController = self.midiaViewController {
                overviewTabController.movie = movie!
                midiaTabController.movie = movie!
            }
        }
    }
    
    var movieRanking: MovieOMDB? {
        didSet {
            if let overviewTabController: OverviewViewController = tabs[0] as? OverviewViewController {
                overviewTabController.movieRanking = movieRanking!
            }
            
        }
    }
    
    func onInit() {
        if !isConfigurate {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Movie", bundle:nil)
            
            overviewViewController = storyBoard.instantiateViewController(withIdentifier: overviewViewControllerIdentifier) as? OverviewViewController
            midiaViewController = storyBoard.instantiateViewController(withIdentifier: midiaViewControllerIdentifier) as? MidiaViewController
            
            tabs = [overviewViewController!, midiaViewController!]
            
            setUpViewPager()
            
            isConfigurate = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setUpViewPager(){
        let frame =  CGRect(x: 0, y: 0, width: self.contentUIView.frame.size.width, height: 1300)
        
        self.viewPager = WormTabStrip(frame: frame)
        
        if let viewPager = self.viewPager {
            self.contentUIView.addSubview(viewPager)
            
            viewPager.delegate = self
            viewPager.eyStyle.wormStyel = .LINE
            viewPager.eyStyle.isWormEnable = true
            viewPager.eyStyle.spacingBetweenTabs = 15
            viewPager.eyStyle.dividerBackgroundColor = UIColor.white
            viewPager.eyStyle.tabItemSelectedColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorAccent)
            viewPager.eyStyle.WormColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorAccent)
            viewPager.eyStyle.topScrollViewBackgroundColor = UIColor.white
            viewPager.eyStyle.contentScrollViewBackgroundColor = UIColor.clear
            viewPager.eyStyle.tabItemDefaultColor = UIColor.black
            
            viewPager.currentTabIndex = 0
            viewPager.buildUI()
            
            viewPager.topAnchor.constraint(equalTo: self.contentUIView.topAnchor).isActive = true
            viewPager.bottomAnchor.constraint(equalTo: self.contentUIView.bottomAnchor).isActive = true
            viewPager.leadingAnchor.constraint(equalTo: self.contentUIView.leadingAnchor).isActive = true
            viewPager.trailingAnchor.constraint(equalTo: self.contentUIView.trailingAnchor).isActive = true
        }
        
    }
    
    func WTSNumberOfTabs() -> Int {
        return 2
    }
    
    func WTSTitleForTab(index: Int) -> String {
        
        switch index {
        case 0:
            return "Overview"
        case 1:
            return "Midia"
        default:
            return "Overview"
        }
    }
    
    func WTSViewOfTab(index: Int) -> UIView {
        let view = tabs[index]
        
        return view.view
        
        
    }
    
    func WTSReachedLeftEdge(panParam: UIPanGestureRecognizer) {
        
    }
    
    func WTSReachedRightEdge(panParam: UIPanGestureRecognizer) {
        
    }
    
    func WTSOnTabSelect(index: Int) {
        tabBarCallback?.onTabBarSelect(index: index)
        
        switch index {
        case 0:
            self.viewPager?.frame = CGRect(x: 0, y: 0, width: self.contentUIView.frame.size.width, height: 1300)
            tabs[0].view?.layoutIfNeeded()
            return
        case 1:
            self.viewPager?.frame = CGRect(x: 0, y: 0, width: self.contentUIView.frame.size.width, height: 800)
            tabs[0].view?.layoutIfNeeded()
            return
        default:
            self.viewPager?.frame = CGRect(x: 0, y: 0, width: self.contentUIView.frame.size.width, height: 800)
            return
        }
    }
    
}

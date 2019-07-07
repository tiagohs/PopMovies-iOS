//
//  CalendarController.swift
//  popmovies
//
//  Created by Tiago Silva on 06/07/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//


import UIKit
import FSCalendar

// MARK: CalendarController: BaseViewController

class CalendarController: BaseViewController {
    
    // MARK: Outlets
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!

    @IBOutlet weak var calendar: FSCalendar!
    
    // MARK: Properties

    var presenter: CalendarPresenterInterface?
    var delegate: CalendarDelegate?
    
    var selectedDate: Date?
}

// MARK: Lifecycle Methods

extension CalendarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.presenter?.viewDidDisappear(animated)
    }
}

extension CalendarController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
    }
    
}

// MARK: CalendarViewInterface - Setup Methods

extension CalendarController: CalendarViewInterface {
    
    func setupUI() {
        closeButton.layer.cornerRadius = closeButton.bounds.width / 2
        finishButton.layer.cornerRadius = finishButton.bounds.width / 2
        
        closeButton.imageView?.setImageColorBy(uiColor: UIColor.white)
        finishButton.imageView?.setImageColorBy(uiColor: UIColor.white)
    }
    
}

extension CalendarController {
    
    @IBAction func didFinishButtonClicked(_ sender: Any) {
        if  let date = self.selectedDate,
            let startWeek = date.startOfWeek,
            let endOfWeek = date.endOfWeek {
            
            delegate?.didSelectNewDate(startWeek, endOfWeek)
        }
        
        self.hero.dismissViewController()
    }
}

//
//  EventDetailViewController.swift
//  Timeline
//
//  Created by Hana  Demas on 9/28/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet var eventTitleLabel: UILabel!
    var selectedEvent: Event?
    
    //MARK: Viewcontroller lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = selectedEvent {
            self.eventTitleLabel.text = event.title
        }
    }
}

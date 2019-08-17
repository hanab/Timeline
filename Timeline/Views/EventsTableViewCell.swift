//
//  EventsTableViewCell.swift
//  Timeline
//
//  Created by Hana  Demas on 9/27/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dailyEventsCollectionView: UICollectionView!
}

//Tableviewcell extension to setup datasource and delgate of collectionview inside it
extension EventsTableViewCell {
    
    //MARK: Functions
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        dailyEventsCollectionView.delegate = dataSourceDelegate
        dailyEventsCollectionView.dataSource = dataSourceDelegate
        dailyEventsCollectionView.tag = row
        
        dailyEventsCollectionView.setContentOffset(dailyEventsCollectionView.contentOffset, animated:false)
        
        dailyEventsCollectionView.reloadData()
    }
}

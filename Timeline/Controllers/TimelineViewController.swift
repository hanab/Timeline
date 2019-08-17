//
//  ViewController.swift
//  Timeline
//
//  Created by Hana  Demas on 9/19/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet var healthPromptMessageLabel: UILabel!
    @IBOutlet var eventsTableView: UITableView!
    
    fileprivate var profileViewModel = ProfileViewModel()
    
    //MARK: ViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventsTableView.dataSource = self
        self.eventsTableView.delegate = self
        
        healthPromptMessageLabel.lineBreakMode = .byWordWrapping
        healthPromptMessageLabel.numberOfLines = 0
        
        profileViewModel.getProfileFromAPI {
            DispatchQueue.main.async {
                self.profileViewModel.groupEventsByDate()
                
                self.healthPromptMessageLabel.text = self.profileViewModel.getHealtPromptMessage()
                self.eventsTableView.reloadData()
            }
        }
    }
}

//MARK: viewcontroller extension for implementing datasource and delegates of UITableview
extension TimelineViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "eventsCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileViewModel.getNumberOfDays()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCell", for: indexPath) as! EventsTableViewCell
        cell.dateLabel.text = self.profileViewModel.getDayAtIndex(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? EventsTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
}

//MARK: viewcontroller extension for implementing datasource and delegates of UICollectionView
extension TimelineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let day = self.profileViewModel.getDayAtIndex(index: collectionView.tag)
        return self.profileViewModel.getNumberOfEvents(day: day)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventsCollectionViewCell
        let day = self.profileViewModel.getDayAtIndex(index: collectionView.tag)
        
        if  let event = self.profileViewModel.getEventAtIndex(day: day, index: indexPath.row) {
            cell.titleLabel.text = event.title
            cell.subtitleLabel.text = event.dateTimeTuple.1
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "eventDetail") as! EventDetailViewController
        let day = self.profileViewModel.getDayAtIndex(index: collectionView.tag)
        
        if  let event = self.profileViewModel.getEventAtIndex(day: day, index: indexPath.row) {
            secondViewController.selectedEvent = event
        }
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    //avoid constraint problems when screen size is less than iphone
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
}

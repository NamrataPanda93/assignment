//
//  ViewController.swift
//  assignment_cygnvs
//
//  Created by Namrata Panda on 22/8/23.
//

import UIKit
import ObjectMapper
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //MARK: - Variables
    var dataViewModel = DataViewModel()
    var locationManager = CLLocationManager()
    var db:DBHelper = DBHelper()
    
    var locations:[Location] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        dataViewModel.updateLocation()
        initViewModel()
        self.dataViewModel.hideLoading?()
    }
  
    //MARK: - ViewModel Initialization
    func initViewModel(){
        updateLocation()
        bindData()
        configureCell()

        dataViewModel.showLoading = {
            DispatchQueue.main.async { self.activityIndicator.startAnimating() }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
        }
        
    }
    
    func updateLocation() {
        LocationManager.shared.updateUserLocation()
        LocationManager.shared.locationFetch = { [weak self] latitude,longitude in
            debugPrint(latitude)
            debugPrint(longitude)

            self?.db.insert(id: 0, timestamp: "\(Date().timeIntervalSince1970)", lat: latitude, long: longitude)
            self?.locations = (self?.db.read())!
            self?.dataViewModel.featureArray.value = self?.locations
        }

    }
    
    
    //MARK: - Bind Data
    func bindData() {
        dataViewModel.configureCollectionView(collectionView: tableView)
        dataViewModel.featureArray.bind { (featureArray) in
            self.dataViewModel.fetureDataSource?.items = featureArray
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }

    }
    
    //MARK: - Cell Configure
    func configureCell() {
        dataViewModel.fetureDataSource?.configureCellBlock = { cell,item,indexPath in
            (cell as? TitleCollectionViewCell)?.featureModel = item as? Location
        }
    }
   

}


//
//  DataViewModel.swift
//  assignment_cygnvs
//
//  Created by Namrata Panda on 22/8/23.
//

import UIKit
import Foundation
import RxSwift

typealias APICompletion = (Any) -> Void

class DataViewModel {
    var fetureDataSource:CollectionViewDataSource?
    var featureArray = Observable<[Location]>([])

    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    //MARK: - Configure CollectionView
    func configureCollectionView(collectionView:UICollectionView?) {
        let cellNib = UINib(nibName: cellStrings.titleTableViewCell.rawValue, bundle: Bundle(for: TitleCollectionViewCell.self))
        collectionView?.register(cellNib, forCellWithReuseIdentifier: cellStrings.titleTableViewCell.rawValue)
        fetureDataSource = CollectionViewDataSource(items: ["", ""], collectionView: collectionView, cellIdentifier: cellStrings.titleTableViewCell.rawValue, minimumLineSpacing: 0, minimumInteritemSpacing: 0)
        
        fetureDataSource?.sizeForItemAt = { indexPath in
            return CGSize(width: collectionView?.frame.size.width ?? 0.0, height: 48)
        }
        
        collectionView?.delegate = fetureDataSource
        collectionView?.dataSource = fetureDataSource
    }
  
    
    
    func updateLocation() {
        LocationManager.shared.updateUserLocation()
    }
      

}



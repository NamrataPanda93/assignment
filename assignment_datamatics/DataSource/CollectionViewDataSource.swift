//
//  CollectionViewDataSource.swift
//  Whatashadi
//
//  Created by Night Reaper on 29/10/15.
//  Copyright © 2015 Gagan. All rights reserved.
//

//MARK:- MODULES
import UIKit

//MARK:- TYPEALIAS
typealias ViewForHeaderInSectionCollectionView = (_ view : AnyObject? , _ indexpath:IndexPath) -> ()
typealias SizeForItemAt = (_ indexPath: IndexPath) -> (CGSize)
typealias MoveCellAt = (_ source:IndexPath,_ destinationIndexPath: IndexPath) -> ()


//MARK:- CLASS
class CollectionViewDataSource: NSObject  {
    
    //MARK:- PROPERTIES
    var items : Array<Any>?
    var cellIdentifier : String?
    var headerIdentifier : String?
    var collectionView  : UICollectionView?
    var cellHeight : CGFloat = 0.0
    var cellWidth : CGFloat = 0.0
    var edgeInsetsMake  = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var minimumLineSpacing : CGFloat = 0.0
    var minimumInteritemSpacing : CGFloat = 0.0
    var scrollViewListener : ScrollViewScrolled?
    var configureCellBlock : ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    var scrollViewDragValue : CGFloat = 0
    var viewforHeaderInSection : ViewForHeaderInSectionCollectionView?
    var sectionHeaderHeight : CGSize?
    var sizeForItemAt:SizeForItemAt?
    var isMoving:Bool = false
    var moveCellAt: MoveCellAt?
    var willDisplayCell: WillDisplayCell?


    init (items : Array<Any>?  ,
          collectionView : UICollectionView?,
          cellIdentifier : String?,
          minimumLineSpacing : CGFloat,
          minimumInteritemSpacing : CGFloat)  {
        
        self.collectionView = collectionView
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
    }
    
    override init() {
        super.init()
    }
}

//MARK:- DELEGATE, DATASOURCE
extension CollectionViewDataSource : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let identifier = cellIdentifier else{
            fatalError("Cell identifier not provided")
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier ,
                                                      for: indexPath) as UICollectionViewCell
        if let block = self.configureCellBlock , let item: Any = self.items?[(indexPath as NSIndexPath).row]{
            block(cell , item , indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let block = self.aRowSelectedListener, case let cell as Any = collectionView.cellForItem(at: indexPath){
            block(indexPath , cell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        if kind == UICollectionView.elementKindSectionHeader{
            
            let viewHeader =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier ?? "", for: indexPath)
            
            if let block = self.viewforHeaderInSection{
                _ = block(viewHeader, indexPath)
            }
            
            return viewHeader
        }
        else {
            return UICollectionReusableView()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let block = willDisplayCell{
            block(indexPath,cell)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let block = scrollViewListener {
            block(scrollView)
        }
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewDragValue = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return isMoving
    }
}

//MARK:- DELEGATEFLOWLAYOUT
extension CollectionViewDataSource : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        guard let sizeForItemAt = sizeForItemAt else{return .zero}
        return sizeForItemAt(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  sectionHeaderHeight ?? CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return edgeInsetsMake
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return minimumInteritemSpacing
    }
}

//
//  TableViewDataSource.swift
//  cygnvs_assignment
//
//  Created by Namrata Panda on 22/08/23.
//

//MARK:- MODULES

import UIKit
import Foundation


typealias  ListCellConfigureBlock = (_ cell : Any , _ item : Any? , _ indexpath: IndexPath?) -> ()
typealias  DidSelectedRow = (_ indexPath : IndexPath , _ cell : Any) -> ()
typealias ViewForHeaderInSection = (_ section : Int) -> UIView?
typealias  WillDisplayCell = (_ indexPath : IndexPath , _ cell : Any) -> ()
typealias ScrollViewScrolled = (UIScrollView) -> ()
typealias  EditingStyle = (_ indexPath : IndexPath , _ cell : Any) -> ()


class TableViewDataSource: NSObject  {
    
    var items : Array<Any>?
    var sections : Array<Any>?
    var cellIdentifier : String?
    var tableView  : UITableView?
    var tableViewRowHeight : CGFloat?
    var configureCellBlock : ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    var viewforHeaderInSection : ViewForHeaderInSection?
    var scrollViewListener : ScrollViewScrolled?
    var headerHeight : CGFloat?
    var willDisplayCell: WillDisplayCell?
    var editingStyle: EditingStyle?
    var headerTitleArray : Array<String>?
    
    
    init (items : Array<Any>? , height : CGFloat , tableView : UITableView? , cellIdentifier : String?
        //, sections : Array<Any> = [""], headerTitleArray : Array<String> = [""] //
    ) {
        
        self.tableView = tableView
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.tableViewRowHeight = height

    }
    
    override init() {
        super.init()
    }
}

extension TableViewDataSource : UITableViewDelegate , UITableViewDataSource, UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let identifier = cellIdentifier else{
            fatalError("Cell identifier not provided")
        }
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if let block = self.configureCellBlock , let item: Any = self.items?[indexPath.row]{
            block(cell , item , indexPath as IndexPath?)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = self.aRowSelectedListener, case let cell as Any = tableView.cellForRow(at: indexPath){
            block(indexPath , cell)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewRowHeight ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let block = viewforHeaderInSection else { return nil }
        return block(section)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let block = self.willDisplayCell {
            block(indexPath,cell)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight ?? 0.0
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let block = scrollViewListener {
            block(scrollView)
        }
    }
    
    
}

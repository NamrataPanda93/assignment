//
//  UIImageViewExtensions.swift
//  assignment_cygnvs
//
//  Created by Namrata Panda  on  22/8/23.
//

import Foundation
import UIKit
import Kingfisher

//MARK: - UIImageViewExtension
extension UIImageView {
    
    //MARK: - Set Image from URL
    func setImageFromUrl(url :String? , placeHolder: UIImage? = nil){
        self.kf.indicatorType = .activity
        if ((url?.isEmpty) == nil) {
            self.image = placeHolder
        }else{
            if let urlTemp = URL(string: url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
                self.kf.setImage(with: urlTemp)
            }
        }
    }
    
}

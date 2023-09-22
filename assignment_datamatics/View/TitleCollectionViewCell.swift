//
//  TitleCollectionViewCell.swift
//  assignment_datamatics
//
//  Created by Namrata Panda on 21/09/23.
//  Copyright © 2023 DesarrolloManzana. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //MARK: - Item
    var featureModel:Location?{
        didSet{
            
            let date = Date(timeIntervalSince1970: Double(featureModel?.timestamp ?? "") ?? 0.0)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            
            titleLabel?.text = "Lat:" + "\(featureModel?.lat ?? 0.0) " + "Long:" + "\(featureModel?.long ?? 0.0) " + strDate
        }
    }

}

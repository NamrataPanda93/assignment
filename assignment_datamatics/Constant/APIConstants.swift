//
//  APIConstants.swift
//  APIClasses
//
//  Created by Namrata Panda on 22/08/22.
//

import Foundation

struct APIConstants {
    
    static var baseURL: String{
        return "https://jsonplaceholder.typicode.com/"//
    }
    
    static let photos = "photos"

}

//MARK: - Alert Strings
enum cellStrings: String{
    case titleTableViewCell = "TitleCollectionViewCell"
}


//MARK: - Alert Strings
enum storyboardStrings: String{
    case main = "Main"
}

enum Result{
    case success(Any?)
    case failure(String?)

}

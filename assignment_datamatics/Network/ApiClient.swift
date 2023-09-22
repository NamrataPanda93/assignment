//
//  ApiClient.swift
//  assignment_cygnvs
//
//  Created by Namrata Panda on 22/8/23.
//

import Foundation

public struct ApiClient {
    
    static func getDataFromServer( complete: @escaping (_ success: Bool, _ data: Any )->() ){
        DispatchQueue.global().async {
            sleep(2)
            guard let url = URL(string: APIConstants.baseURL + APIConstants.photos) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        guard let jsonArray = json as? [[String:Any]] else{return}
                        print(jsonArray)
                        complete(true, jsonArray)
                        
                    } catch {
                        return
                    }
                }
                
            }.resume()
            
        }
        
    }
}

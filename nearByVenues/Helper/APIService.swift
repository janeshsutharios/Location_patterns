//
//  APIService.swift
//  nearByVenues
//
//  Created by Jitendra Gaur on 3/17/17.
//  Copyright © 2017 Jitendra Gaur. All rights reserved.
//

import Foundation
import Alamofire

struct APIService {
        
    static func getData(inputUrl:String,parameters:[String:Any],completion:@escaping(_:Any)->Void){
        let url = URL(string: inputUrl)
        Alamofire.request(url!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            let nilValue = ""
            if let JSON = response.result.value {
                completion(JSON)
            }
            else {
                completion(nilValue)
            }
        }
    }
    static func postData(parameters:[String:Any],completion:@escaping(_:[Venue])->Void){
        
    }
    static func putData(parameters:[String:Any],completion:@escaping(_:[Venue])->Void){
        
    }
    static func deleteData(parameters:[String:Any],completion:@escaping(_:[Venue])->Void){
        
    }
    
}

//
//  Constants.swift
//  nearByVenues
//
//  Created by Jitendra Gaur on 3/17/17.
//  Copyright © 2017 Jitendra Gaur. All rights reserved.
//

import UIKit

let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)

struct Constants {
     static let baseURL = "https://api.foursquare.com/v2/venues/search/?"

    struct ForeSqure_API {
        static let URL = "https://api.foursquare.com/v2/"
        static let CLIENT_ID = "HJARTVAQQEDPDRFHEWMX0KL1CN2OFMH3FKG0WXTR11ZMTZAE"
        static let CLIENT_SECRET = "K3VWRDINVZDXUCQW5Y10OSNNLYYGDVROAWNJM4J4SX4DZCNC"
    }
    
}
struct CustomAlert {
    static func showAlert(_ title:String , message:String!, controller:UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}


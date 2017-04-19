//
//  VenueDetailViewController.swift
//  nearByVenues
//
//  Created by Jitendra Gaur on 3/17/17.
//  Copyright © 2017 Jitendra Gaur. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    
    var venue: Venue!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelName.text = venue.name
        
        var formatedAddress = ""
        
        for address in venue.location.formattedAddress {
            formatedAddress += address + "\n"
        }
        
        labelAddress.text = formatedAddress
        
    }


}

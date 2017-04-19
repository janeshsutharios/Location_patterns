//
//  VenusTableViewCell.swift
//  nearByVenues
//
//  Created by Jitendra Gaur on 3/18/17.
//  Copyright © 2017 Jitendra Gaur. All rights reserved.
//

import UIKit

class VenusTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    var venues = [Venue]()

    func setupData(venues:[Venue],index:Int){
        let venue = venues[index]
        
        labelName.text = venue.name
        let distance = venue.location.distance
        labelDistance.text = distance < 1000 ? "\(distance)m" : "\(distance/1000)Km"
    }
}

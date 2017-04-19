//
//  LocationGetter.swift
//  Homify
//
//  Created by webwerks on 10/21/16.
//  Copyright © 2016 homify. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

// MARK: -  LocationHandlerDelegate  declare protocol
@objc protocol LocationHandlerDelegate
{
    // MARK: -  LocationHandlerDelegate functions
    func locationUpdate(location: CLLocation)
    func locationError(error: NSError)
    @objc optional func locationServiceAreDisbaled()
    @objc optional func locationServiceAreDeniedOrRestricted()
}
class LocationSetings {
    
    var address: String
    var icon: String
    var latitude : Double
    var longitude : Double
    var name : String
    
    init(address: String, icon: String, latitude : Double, longitude : Double, name : String ) {
        self.address = address
        self.icon = icon
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
}

// MARK: -  LocationHandler declare class and adopt location manager protocol
class LocationHandler: NSObject {
    
    static var instance: LocationHandler!
    
    class func sharedInstance() -> LocationHandler
    {
        self.instance = (self.instance ?? LocationHandler())
        return self.instance
    }
    
    var currentLocation:CLLocation?
    
    //declare locationmanager class object and initlize it
    internal var locationManager:CLLocationManager = CLLocationManager()
    
    //declare protocol weak property
    weak var delegate:LocationHandlerDelegate?
    
    // MARK: -  getLocation
    func getLocation() {
        
        //taking location manager delegation ownership
        self.locationManager.delegate = self;
        //setting accuracy value
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        //checking   location services authorization Status
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        //checking is user denied or denied the services
        if authorizationStatus == .restricted || authorizationStatus == .denied {
            
            self.delegate?.locationServiceAreDeniedOrRestricted?()
        }else if !CLLocationManager.locationServicesEnabled() {
            
            self.delegate?.locationServiceAreDisbaled?()
        }else{
            
            let selector = #selector(self.locationManager.requestWhenInUseAuthorization)
            if self.locationManager.responds(to:selector) {
                
                if authorizationStatus == .authorizedAlways
                    || authorizationStatus == .authorizedWhenInUse {
                    
                    self.locationManager.startUpdatingLocation()
                }else{
                    
                    self.locationManager.requestWhenInUseAuthorization()
                }
                
            }else{
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func showLocationAlert () {
        
        let window =  UIApplication.shared.windows.first
        CustomAlert.showAlert("ff", message: "dd", controller: (window?.rootViewController)!)
        }
    
    func showLocationErrorAlert () {
        
        let window =  UIApplication.shared.windows.first
        CustomAlert.showAlert("ff", message: "d", controller: (window?.rootViewController)!)
    }
    
    //geting the place name from the CLLoction coordinates
    func reverseGeocoding(completion: @escaping (LocationSetings?) -> Void) {
        
        CLGeocoder().reverseGeocodeLocation(self.currentLocation!,
                                            completionHandler:
            {
                (placemarks, error) -> Void in
                
                if (placemarks?.count)! > 0 {
                let pm = (placemarks?[0])! as CLPlacemark
                
                let addressDict = pm.addressDictionary! as [AnyHashable : AnyObject]
                let array = addressDict["FormattedAddressLines"] as! [String]
                let address = array.joined(separator: ", ")
                
                let latitude : Double = (pm.location?.coordinate.latitude)!
                let longitude : Double = (pm.location?.coordinate.longitude)!
                
                let location = LocationSetings(address: address, icon: "", latitude: latitude, longitude: longitude, name: pm.locality!)
                    
                completion(location)
            }else{
                completion(nil)
            }
        })
    }
  
}
extension  LocationHandler: CLLocationManagerDelegate{
    // MARK: -  CLLocationManager delegate method didChangeAuthorizationStatus
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        // comapring Authorization Status and perfrom operation accordingly
        switch status {
        case .notDetermined:
            self.locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            break
        case .restricted:
            self.delegate?.locationServiceAreDeniedOrRestricted?()
            break
        case .denied:
            self.delegate?.locationServiceAreDeniedOrRestricted?()
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }
    
    // MARK: -  CLLocationManager delegate method didUpdateLocations
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        if locations.count>0{
            //taking location array last object and comapre the timestamp if timestamp is greater than 5 seconds then ignoring thta location value
            let newLocation:CLLocation=locations.last!
            let locationAge:TimeInterval = -newLocation.timestamp.timeIntervalSinceNow
            if locationAge > 5.0 {
                return;
            }
            //comapring horizontal accuracy
            if newLocation.horizontalAccuracy >= 0 && newLocation.horizontalAccuracy <= 500
            {
                //stop location manager updating processure
                self.locationManager.stopUpdatingLocation()
                self.currentLocation=newLocation
                //here I am calling locationhandler protocol method to send location
                self.delegate?.locationUpdate(location: newLocation)
            }
        }
    }
    
    // MARK: -  CLLocationManager delegate method didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        self.locationManager.stopUpdatingLocation()
        //here I am calling locationhandler protocol method to show error
        if (self.delegate != nil) {
            self.delegate?.locationError(error: error as NSError)
        }
    }
    
}

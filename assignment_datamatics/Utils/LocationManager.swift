//
//  LocationManager.swift
//  Onatajobs
//
//  Created by S Chitvan  on 2/14/19.
//  Copyright © 2019 ChitvanSaxena. All rights reserved.
//

import UIKit
import CoreLocation

typealias JSONDictionary = [String:Any]

class LocationManager: NSObject,CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager?
    var currentLoc : CLLocation?
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    var locationFetch: ((_ latitude:CGFloat , _ longitude: CGFloat ) -> ())?
    var address: String?
    var restrictedHandler:((Bool) -> Void)?
    
    override init() {
        super.init()
        locationInitializer()
    }
    
    static let shared = LocationManager()
    
    func updateUserLocation(){
        locationInitializer()
        updateLocation()
    }
    
    func stopLocationUpdating() {
        locationManager?.delegate = nil
        locationManager?.stopUpdatingLocation()
    }
    
    func updateLocation(){
        locationManager?.delegate = nil
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    func locationInitializer(){
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse,.authorizedAlways:
            locationManager?.startUpdatingLocation()
            restrictedHandler?(false)
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
            restrictedHandler?(false)
        case .restricted,.denied:
            //settingsAlert()
            restrictedHandler?(true)

        }
    }
    
    func settingsAlert () {
        
//        UtilityFunctions.sharedInstance.show(alert: "Enable location access", message: "Please enable location permission from settings", buttonText: "OK", buttonOk: {
//            self.openSettings()
//        })
    }
    
    func openSettings(){
        
//        let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString)! as URL
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
//        } else {
//            // Fallback on earlier versions
//            let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
//            if let url = settingsUrl {
//                UIApplication.shared.openURL(url)
//            }
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLoc = locations.last
        
        if let lat = currentLoc?.coordinate.latitude ,let lng = currentLoc?.coordinate.longitude {
            latitude = lat
            longitude = lng
            locationFetch?(CGFloat(lat) ,CGFloat(lng))
        }else{
            locationFetch?(0.0,0.0)
        }
    }
    
   
}

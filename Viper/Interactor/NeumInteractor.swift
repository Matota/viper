//
//  NeumInteractor.swift
//  Neum
//
//  Created by Hitesh Ahuja on 24/04/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation
import CoreLocation

enum NeumOperation: Int, CustomStringConvertible {
    
    case fetchAddress
    
    var description: String {
        switch self {
        case .fetchAddress :return "address"
        }
    }
}

protocol NeumBusinessLogic {
    func getAddressDetails(lat: Double, long : Double)
}

class NeumInteractor: NeumBusinessLogic {
   
    // This variable is to pass the data of the api response to the presenter class.
    var presenter: NeumPresentationLogic?
    
    func getAddressDetails(lat: Double, long : Double) {
        
         let coords = CLLocation(latitude:lat, longitude: long)
        
        CLGeocoder().reverseGeocodeLocation(coords) { (placemark, error) in
            if error != nil {
                print("Hay un error")
            } else {
                
                let place = placemark! as [CLPlacemark]
                if place.count > 0 {
                    let place = placemark![0]
                    var adressString : String = ""
                    if place.thoroughfare != nil {
                        adressString = adressString + place.thoroughfare! + ", "
                    }
                    if place.subThoroughfare != nil {
                        adressString = adressString + place.subThoroughfare! + "\n"
                    }
                    if place.locality != nil {
                        adressString = adressString + place.locality! + " - "
                    }
                    if place.postalCode != nil {
                        adressString = adressString + place.postalCode! + "\n"
                    }
                    if place.subAdministrativeArea != nil {
                        adressString = adressString + place.subAdministrativeArea! + " - "
                    }
                    if place.country != nil {
                        adressString = adressString + place.country!
                    }
                    
                    self.presenter?.presentAddressDetails(response: adressString)
                }
            }
        }
    }

}

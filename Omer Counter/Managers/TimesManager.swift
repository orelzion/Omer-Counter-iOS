//
//  TimesManager.swift
//  Omer Counter
//
//  Created by Orel Zion on 13/04/2021.
//

import Foundation
import Solar
import MapKit
import Combine

class TimesManager: NSObject, ObservableObject {
    
    @Published var hebrewDate: Date? = nil
    
    func onLocationRecevied(location: CLLocation) {
        // Getting solat information for current location
        let solar = Solar(coordinate: location.coordinate)
        
        // Getting sunset times
        guard let sunset = solar?.sunset else {
            //TODO report error
            return
        }
        
        onSunsetSet(sunset: sunset)
    }
    
    func onSunsetSet(sunset: Date) {
        let current = Date()
        
        // If now is before sunset - use current date
        // otherwise - use tomorrow
        let daysToAdd = (current > sunset) ? 1 : 0
        
    
        // Setting Hebrew date using Hebrew calendar
        self.hebrewDate = Calendar(identifier: .hebrew).date(byAdding: .day, value: daysToAdd, to: current)
    }
}

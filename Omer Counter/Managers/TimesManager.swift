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
    
    private var locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    @Published var hebrewDate: Date? = nil
    
    override init() {
        super.init()
        
        // Subscribe to location updates
        locationManager.$location
            .sink(receiveValue: { (loc: CLLocation?) in
                // If we recevive an actual location, get its solar details
                if(loc != nil) {
                    self.onLocationRecevied(location: loc!)
                }
            }).store(in: &cancellables) // Observables must be stored, or you won't get any updates
    }
    
    func onLocationRecevied(location: CLLocation) {
        // Getting solat information for current location
        let solar = Solar(coordinate: location.coordinate)
        
        // Getting sunset times
        guard let sunset = solar?.astronomicalSunset else {
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

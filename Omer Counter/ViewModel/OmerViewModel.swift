//
//  OmerViewModel.swift
//  Omer Counter
//
//  Created by Orel Zion on 17/04/2021.
//

import SwiftUI
import Combine
import MapKit

class OmerViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var showProgress = true
    @Published private(set) var textLines: [OmerTextLine] = []
    
    private var locationManager = LocationManager()
    private var timesManager = TimesManager()
    private var omerManager = OmerManager()
    private let defaults = UserDefaults()
    
    fileprivate func observeLocation() {
        // Subscribe to location updates
        locationManager.$location
            .sink(receiveValue: { (loc: CLLocation?) in
                // If we recevive an actual location, get its solar details
                if(loc != nil) {
                    self.timesManager.onLocationRecevied(location: loc!)
                }
            }).store(in: &cancellables) // Observables must be stored, or you won't get any updates
    }
    
    fileprivate func observeHebrewDate() {
        // Subscribe to hebrew date updates
        timesManager.$hebrewDate.sink { (hebrewData: Date?) in
            if(hebrewData != nil) {
                self.omerManager.onDateUpdated(hebrewDate: hebrewData!)
            }
        }.store(in: &cancellables)
    }
    
    fileprivate func observeOmerDay() {
        // Subscribe to omer day updates
        omerManager.$omerDay
            .sink { (omer: Int?) in
                guard let omerDay = omer else {
                    return
                }
                
                self.showProgress = false
                self.textLines = self.createTextLines(omerDay: omerDay)
            }.store(in: &cancellables)
    }
    
    func loadOmerText() {
        observeLocation() // 1. We get the location
        observeHebrewDate() // 2. We get the sunset time and determine the hebrew date
        observeOmerDay() // 3. Based on the Hebrew date we determine the Omer day
    }
    
    private func createTextLines(omerDay: Int) -> [OmerTextLine] {
        let nusach: Nusach
        switch defaults.string(forKey: "nusach") {
            case "edot":
                nusach = .Edot
            case "sfarad":
                nusach = .Sfarad
            case "ashkenaz":
                nusach = .Ashkenaz
            case "chabad":
                nusach = .Chabad
            default:
                nusach = .Edot
        }
        return OmerGenerator(nusach: nusach, omerDay: omerDay - 1).generate()
    }
}

//
//  OmerManager.swift
//  Omer Counter
//
//  Created by Orel Zion on 14/04/2021.
//

import Foundation
import Combine

class OmerManager: NSObject, ObservableObject {
    
    private var timesManager = TimesManager()
    private var cancellables = Set<AnyCancellable>()
    @Published var omerDay: Int? = nil
    
    override init() {
        super.init()
        
        timesManager.$hebrewDate.sink { (hebrewData: Date?) in
            if(hebrewData != nil) {
                self.onDateUpdated(hebrewDate: hebrewData!)
            }
        }.store(in: &cancellables)
    }
    
    func onDateUpdated(hebrewDate: Date) {
        let diffs = Calendar(identifier: .hebrew).dateComponents([.day], from: getFirstOmerDay(), to: hebrewDate)
        self.omerDay = diffs.day!
    }
    
    func getFirstOmerDay() -> Date {
        // Create Hebrew calendar
        let current = Calendar(identifier: .hebrew)
        
        // Extract its components
        var components = current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        
        // Set date to 15 of Nissan
        components.month = 8
        components.day = 15
        components.hour = 1
        
        return current.date(from: components)!
    }
}

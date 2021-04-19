//
//  OmerViewModel.swift
//  Omer Counter
//
//  Created by Orel Zion on 17/04/2021.
//

import SwiftUI
import Combine

class OmerViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var showProgress = true
    @Published private(set) var textLines: [OmerTextLine] = []
    
    private var omerManager = OmerManager()
    private let defaults = UserDefaults()
    
    func loadOmerText() {
        omerManager.$omerDay
            .sink { (omer: Int?) in
                guard let omerDay = omer else {
                    return
                }
                
                self.showProgress = false
                self.textLines = self.createTextLines(omerDay: omerDay)
            }.store(in: &cancellables)
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

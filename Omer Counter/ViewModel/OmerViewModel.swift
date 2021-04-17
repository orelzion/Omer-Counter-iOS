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
        let whisper: LocalizedStringKey = "whisper"
        return [
            OmerTextLine(text: beforeOmer),
            OmerTextLine(text: self.getOmerDayFormatted(omerDay)),
            OmerTextLine(text: String(format: afterOmer, whisper.stringValue()))
        ]
    }
    
    private func getOmerDayFormatted(_ omerDay: Int) -> String {
        return "<big>\(omerDays[omerDay - 1])</big>"
    }
}

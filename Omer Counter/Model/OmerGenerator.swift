//
//  OmerGenerator.swift
//  Omer Counter
//
//  Created by Orel Zion on 18/04/2021.
//

import SwiftUI

struct OmerGenerator {
    let nusach: Nusach
    let omerDay: Int
    
    func generate() -> [OmerTextLine] {
        switch nusach {
        case .Edot:
            let whisper: LocalizedStringKey = "whisper"
            return [
                OmerTextLine(text: OmerTexts.Edot().beforeOmer),
                OmerTextLine(text: self.getOmerDayFormatted(omerDay, nusach: nusach)),
                OmerTextLine(text: String(format: OmerTexts.Edot().afterOmer, whisper.stringValue()))
            ]
        case .Sfarad:
            let whisper: LocalizedStringKey = "whisper"
            return [
                OmerTextLine(text: OmerTexts.Sfarad().beforeOmer),
                OmerTextLine(text: self.getOmerDayFormatted(omerDay, nusach: nusach)),
                OmerTextLine(text: String(format: OmerTexts.Sfarad().afterOmer, whisper.stringValue(), OmerTexts().omerSfera[omerDay]))
            ]
        case .Ashkenaz:
            let whisper: LocalizedStringKey = "whisper"
            return [
                OmerTextLine(text: OmerTexts.Sfarad().beforeOmer),
                OmerTextLine(text: self.getOmerDayFormatted(omerDay, nusach: nusach)),
                OmerTextLine(text: String(format: OmerTexts.Sfarad().afterOmer, whisper.stringValue(), OmerTexts().omerSfera[omerDay]))
            ]
        case .Chabad:
            let whisper: LocalizedStringKey = "whisper"
            return [
                OmerTextLine(text: OmerTexts.Chabad().beforeOmer),
                OmerTextLine(text: self.getOmerDayFormatted(omerDay, nusach: nusach)),
                OmerTextLine(text: String(format: OmerTexts.Sfarad().afterOmer, whisper.stringValue(), OmerTexts().omerSfera[omerDay]))
            ]
        }
    }
    
    private func getOmerDayFormatted(_ omerDay: Int, nusach: Nusach) -> String {
        let omerDayText: String
        switch nusach {
        case .Edot:
            omerDayText = OmerTexts.Edot().omerDays[omerDay]
        case .Sfarad, .Chabad:
            omerDayText = OmerTexts.Sfarad().omerDays[omerDay]
        case .Ashkenaz:
            omerDayText = OmerTexts.Ashkenaz().omerDays[omerDay]
        }
        
        return "<big>\(omerDayText)</big>"
    }
}

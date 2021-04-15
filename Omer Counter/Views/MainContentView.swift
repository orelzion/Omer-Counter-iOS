//
//  MainContentView.swift
//  Omer Counter
//
//  Created by Orel Zion on 13/04/2021.
//

import SwiftUI

struct MainContentView: View {
    
    @State var omerDay: Int?
    
    var body: some View {
        
        let textLines:Array<OmerTextLine> = [
            OmerTextLine(text: beforeOmer),
            OmerTextLine(text: self.getOmerDayFormatted()),
            OmerTextLine(text: afterOmer)
        ]
        
        Color("BackgroundColor")
            .edgesIgnoringSafeArea(.all)
            .overlay(
                OmerTextView(textLines: textLines)
                    .environment(\.layoutDirection, .rightToLeft)
            )
    }
    
    private func getOmerDayFormatted() -> String {
        return "<big>\(omerDays[self.getOmerDay()])</big>"
    }
    
    private func getOmerDay() -> Int {
        return (omerDay ?? 1) - 1
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView(omerDay: 1)
    }
}

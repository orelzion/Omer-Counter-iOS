//
//  OmerTextView.swift
//  Omer Counter
//
//  Created by Orel Zion on 12/04/2021.
//

import SwiftUI

struct OmerTextView: View {
    
    let textLines: Array<OmerTextLine>
    
    var body: some View {
        List(textLines, id: \.id) { textLine in
            AttributedText(textLine.text)
                .listRowBackground(Color.clear)
                .padding()
        }.navigationTitle("header")
            .listRowBackground(Color.clear)
    }
}

struct OmerTextView_Previews: PreviewProvider {
    static var previews: some View {
        OmerTextView(textLines: [
            OmerTextLine(text: "שלום לכם ילדים וילדות"),
            OmerTextLine(text: "אני יובל המבולבל"),
            OmerTextLine(text: "כל היום אני עושה שטויות")
        ])
    }
}

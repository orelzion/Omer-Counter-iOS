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
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(textLines, id: \.id) { textLine in
                    AttributedText(textLine.text)
                        .listRowBackground(Color.clear)
                        .padding()
                }
            }
        }
    }
}

struct OmerTextView_Previews: PreviewProvider {
    static var previews: some View {
        OmerTextView(textLines: [OmerTextLine(text: "")])
    }
}

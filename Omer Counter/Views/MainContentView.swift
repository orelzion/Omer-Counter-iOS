//
//  MainContentView.swift
//  Omer Counter
//
//  Created by Orel Zion on 13/04/2021.
//

import SwiftUI

struct MainContentView: View {
    let textLines:Array<OmerTextLine> = []
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        Color("BackgroundColor")
            .edgesIgnoringSafeArea(.all)
            .overlay(
                OmerTextView(textLines: textLines)
            )
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

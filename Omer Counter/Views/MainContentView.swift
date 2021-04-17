//
//  MainContentView.swift
//  Omer Counter
//
//  Created by Orel Zion on 13/04/2021.
//

import SwiftUI

struct MainContentView: View {
    
    @ObservedObject var viewModel = OmerViewModel()
    
    var body: some View {
        Color("BackgroundColor")
            .edgesIgnoringSafeArea(.all)
            .overlay(
                OmerTextView(textLines: viewModel.textLines)
                    .environment(\.layoutDirection, .rightToLeft)
            ).onAppear(perform: {
                viewModel.loadOmerText()
            })
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

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
        NavigationView {
            OmerTextView(textLines: viewModel.textLines)
                .environment(\.layoutDirection, .rightToLeft)
        }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                viewModel.loadOmerText()
            }.onAppear(perform: {
                viewModel.loadOmerText()
            })
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

//
//  ContentView.swift
//  Omer Counter
//
//  Created by Orel Zion on 12/04/2021.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    var body: some View {
        return ZStack {
            MainContentView().font(Font.custom("ShofarRegular", size: 22))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

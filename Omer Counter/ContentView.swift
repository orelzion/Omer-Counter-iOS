//
//  ContentView.swift
//  Omer Counter
//
//  Created by Orel Zion on 12/04/2021.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var omerManager = OmerManager()
    
    var body: some View {
        
        let omerDay = omerManager.omerDay
        
        return ZStack {
            MainContentView(omerDay: omerDay).font(Font.custom("ShofarRegular", size: 18))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
            MainContentView()
            if(omerDay != nil) {
                Text("\(omerDay!)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

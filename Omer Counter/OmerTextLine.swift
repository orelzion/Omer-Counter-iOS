//
//  OmerTextLine.swift
//  Omer Counter
//
//  Created by Orel Zion on 12/04/2021.
//

import Foundation

struct OmerTextLine: Decodable, Identifiable {
    let id = UUID()
    let text: String
}

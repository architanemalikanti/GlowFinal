//
//  Outfit.swift
//  GlowGirl
//
//  Created by Archita Nemalikanti on 7/30/25.

import Foundation
import SwiftUI

struct Outfit {
    let id = UUID()
    let name: String
    let emoji: String
    let description: String
    let vibe: String
    let items: [String]
    let price: String
    let category: String
    let colorScheme: [Color]
}

//
//  Item.swift
//  NukkitManager
//
//  Created by Ayumu Urakami on 2025/03/28.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

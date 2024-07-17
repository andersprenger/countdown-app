//
//  Item.swift
//  CountdownApp
//
//  Created by Anderson Sprenger on 17/07/24.
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

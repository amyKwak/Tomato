//
//  Task.swift
//  Pomofocus WatchKit Extension
//
//  Created by Amy Kwak on 5/5/22.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    let text: String
}

//
//  Card.swift
//  Project17_Flashzilla
//
//  Created by admin on 09/03/2023.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

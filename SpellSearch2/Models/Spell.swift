//
//  Spell.swift
//  SpellSearch2
//
//  Created by RYAN GREENBURG on 2/7/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

struct Spells: Codable {
    let results: [Spell]
}

struct Spell: Codable {
    let name: String
    let url: String
}

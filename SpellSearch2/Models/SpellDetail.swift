//
//  SpellDetail.swift
//  SpellSearch2
//
//  Created by RYAN GREENBURG on 2/7/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

struct SpellDetail: Codable {
    let name: String
    let level: Int
    var description: [String]
    let higherLevel: [String]?
    let range: String
    let components: [String]
    let duration: String
    let concentration: String
    let castingTime: String
    let school: School
    let page: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case level
        case description = "desc"
        case higherLevel = "higher_level"
        case range
        case components
        case duration
        case concentration
        case castingTime = "casting_time"
        case school
        case page
        
    }
}

struct School: Codable {
    let name: String
}

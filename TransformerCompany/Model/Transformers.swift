//
//  File.swift
//  TransformerCompany
//
//  Created by Jeff Mew on 2017-11-24.
//  Copyright © 2017 Jeff Mew. All rights reserved.
//

import Foundation

enum RobotType {
    case Autobot
    case Decepticon
}

struct Transformers {
    struct stats {
        static let name = "Name"
        static let robotType = "Robot Type"
        static let strength = "Strength"
        static let intelligence = "Intelligence"
        static let speed = "Speed"
        static let endurance = "Endurace"
        static let rank = "Rank"
        static let courage = "Courage"
        static let firepower = "Fire Power"
        static let skill = "Skill"
    }
    
    struct leaders {
        static let optimusprime = "Optimus Prime"
        static let predaking = "Predaking"
    }
    
    var name: String = ""
    var robotType: RobotType = .Autobot
    var strength: Int = 1
    var intelligence: Int = 1
    var speed: Int = 1
    var endurance: Int = 1
    var rank: Int = 1
    var courage: Int = 1
    var firepower: Int = 1
    var skill: Int = 1
}

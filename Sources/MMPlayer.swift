//
//  MMPlayer.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/20/16.
//
//

import Foundation
import OCTJSON
import OCTFoundation


final class MMPlayer {
    
    var key: String
    
    var level: Int = 0
    
    var fabao: [String]?
    
    var cards: [String]?
    
    var guardian: [String]?
    
    var gold: Int = 0
    

    init(id: String) {
        self.key = id
    }
    
    
    init(fromJSON json: JSON) {
        self.key     = json["id"].string!
    }
    
    
}



func ==(p1: MMPlayer, p2: MMPlayer) -> Bool {
    return p1.key == p2.key
}







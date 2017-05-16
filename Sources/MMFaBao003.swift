//
//  MMFaBao003.swift
//  AAA
//
//  Created by yuhan zhang on 10/29/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMFaBao003: MMFabaoModel, MMUnitFlow {
 
    var key: String = "003"
    var id: Int = 3
    var name: String = "虎符"
    
    
    var hp: Int = 100
    var atk: Int = 0
    var def: Int = 10
    var mag: Int = 0
    var spd: Int = 10
    
    var baoji: Int = 0
    var shanbi: Int = 0
    var mingzhong: Int = 0
    var gedang: Int = 0
    
    
    var zaisheng: Int = 0
    var xixue: Int = 0
    var fantanwuli: Int = 0
    var fantanfashu: Int = 0
    
    
    func willHit(character: MMUnit, ofPlayer player: MMBattlePlayer) {
        character.sp += 1
        
        let dict: [String: Any] = ["playerkey": player.key,
                                   "cardkey": character.key,
                                   "cellid": character.position,
                                   "reason": "changesp",
                                   "sp": character.sp]
        
        player.battle.record.putBeforeFight(dict)
        
    }
    
    
}

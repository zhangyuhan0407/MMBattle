//
//  MMFaBao001.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMFaBao001: MMFabaoModel, MMUnitObservable {
    
    var key: String = "001"
    var id: Int = 1
    var name: String = "兵法二十四篇"
    
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
    
    
    func onHPChanged(character: MMUnit, newValue: inout Int, oldValue: Int) {
        
        for char in character.player.aliveCharacters {
            char.hp += char.maxHP.multiply(0.45)
            
            let dict: [String: Any] = ["playerkey": character.player.key,
                                        "cardkey": character.key,
                                        "cellid": character.position,
                                        "reason": "changehp",
                                        "hp": character.hp,
                                        "maxhp": character.maxHP,
                                        "offsethp": char.maxHP.multiply(0.45)]
            
            
            character.player.battle.record.putAfterFight(dict)
        }
    }
    
    
}




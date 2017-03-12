//
//  MMGDZhanYiGaoAng.swift
//  AAA
//
//  Created by yuhan zhang on 10/28/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMGDZhanYiGaoAng: MMGuardian {
    
    var key = "zhanyigaoang"
    var id = 5
    var name = "战役高昂"
    
    func act(player: MMBattlePlayer) {
        
        var affectArray = [MMAffectState]()
        
        for char in player.aliveCharacters {
            char.addBuff(MMBuffShiXue())
            
            let damage = MMDamage(source: player.characters[0])
            damage.destination = char
            
            let affect = MMAffectState(playerKey: player.key, damage: damage)
            affectArray.append(affect)
        }
        
        let guardianState = MMGuardianState(playerKey: player.key, guardianKey: self.key, affectArray: affectArray)
        player.battle!.record.putGuardian(guardianState)
    }
    
    
}

////
////  MMGDHuiMieBoDong.swift
////  AAA
////
////  Created by yuhan zhang on 10/28/16.
////  Copyright © 2016 octopus. All rights reserved.
////
//
//import Foundation
//
//
//class MMGDHuiMieBoDong: MMGuardian {
//    
//    var key = "huimiebodong"
//    var id = 3
//    var name = "毁灭波动"
//    
//    
//    func act(player: MMBattlePlayer) {
//        
//        var affectArray = [MMAffectState]()
//        
//        for char in player.enemy.aliveCharacters {
//            let offset = char.maxHP.multiply(0.5)
//            char.hp -= offset
//            
//            let damage = MMDamage(source: player.characters[0])
//            damage.value = offset
//            damage.destination = char
//            
//            let affect = MMAffectState(playerKey: player.enemy.key, damage: damage)
//            
//            affectArray.append(affect)
//        }
//        
//        let guardianState = MMGuardianState(playerKey: player.key, guardianKey: self.key, affectArray: affectArray)
//        player.battle!.record.putGuardian(guardianState)
//    }
//    
//}

////
////  MMGDZaiShengLongHou.swift
////  AAA
////
////  Created by yuhan zhang on 10/28/16.
////  Copyright © 2016 octopus. All rights reserved.
////
//
//import Foundation
//
//
//class MMGDZaiShengLongHou: MMGuardian {
//    
//    var key = "zaishenglonghou"
//    var id = 4
//    var name = "再生龙吼"
//    
//    func act(player: MMBattlePlayer) {
//        
//        var affectArray = [MMAffectState]()
//        
//        for char in player.aliveCharacters {
//            let offset = char.maxHP.multiply(1)
//            char.hp += offset
//            
//            let damage = MMDamage(source: player.characters[0])
//            damage.value = -offset
//            damage.destination = char
//            
//            let affect = MMAffectState(playerKey: player.key, damage: damage)
//            
//            affectArray.append(affect)
//        }
//        
//        let guardianState = MMGuardianState(playerKey: player.key, guardianKey: self.key, affectArray: affectArray)
//        player.battle!.record.putGuardian(guardianState)
//    }
//}

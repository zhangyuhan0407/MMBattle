////
////  MMGDJiuXiaoLongYin.swift
////  AAA
////
////  Created by yuhan zhang on 10/28/16.
////  Copyright © 2016 octopus. All rights reserved.
////
//
//import Foundation
//
//
//class MMGDJiuXiaoLongYin: MMGuardian {
//    
//    var key = "jiuxiaolongyin"
//    var id = 2
//    var name = "九霄龙吟"
//    
//    func act(player: MMBattlePlayer) {
//        
//        var affectArray = [MMAffectState]()
//        
//        
//        for char in player.enemy.aliveCharacters {
//            let offset = char.hp.multiply(0.1)
//            char.sp -= 1
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
//    
//    
//    
//}

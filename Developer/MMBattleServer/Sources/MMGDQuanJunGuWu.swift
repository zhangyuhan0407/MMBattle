////
////  MMGDQuanJunGuWu.swift
////  AAA
////
////  Created by yuhan zhang on 10/28/16.
////  Copyright © 2016 octopus. All rights reserved.
////
//
//import Foundation
//
//
//class MMGDQuanJunGuWu: MMGuardian {
//    
//    var key = "quanjunguwu"
//    var id = 1
//    var name = "全军鼓舞"
//    
//    func act(player: MMBattlePlayer) {
//        var affectArray = [MMAffectState]()
//        
//        for char in player.aliveCharacters {
//            char.sp += 5
//            
//            let damage = MMDamage(source: player.characters[0])
//            damage.destination = char
//            
//            let affect = MMAffectState(playerKey: player.key, damage: damage)
//
//            affectArray.append(affect)
//            
//        }
//        
//        let guardianState = MMGuardianState(playerKey: player.key, guardianKey: self.key, affectArray: affectArray)
//        player.battle!.record.putGuardian(guardianState)
//        
//        
//        
//    }
//    
//}

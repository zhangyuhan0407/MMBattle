//
//  MMBattleRepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Foundation


class MMBattleRepo {
    
    static func createBattle(type: String, p1: MMBattlePlayer, p2: MMBattlePlayer) -> MMBattle {
        let battle = MMBattle(type: type, p1: p1, p2: p2)
        p1.battle = battle
        p2.battle = battle
        return battle
    }
    
}


class MMPVPBattleRepo {
    
    static func createPVPBattle(type: String, p1: MMBattlePlayer, p2: MMBattlePlayer) -> MMPVPBattle {
        let battle = MMPVPBattle(type: type, p1: p1, p2: p2)
        p1.battle = battle
        p2.battle = battle
        return battle
    }
    
    
}

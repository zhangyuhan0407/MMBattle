//
//  MMBattlePlayer.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/20/16.
//
//

import Foundation
import OCTJSON
import OCTFoundation


class MMBattlePlayer {
    
    weak var _battle: MMBattle?
    
    var battle: MMBattle {
        return _battle!
    }
    
    var key: String
    
    
    var enemy: MMBattlePlayer {
        return self.battle.enemy(forPlayer: self)
    }
    
    var record: MMBattleRecord {
        return self.battle.record
    }
    
    
    var speed: Int {
        return self.characters.reduce(0, { (a: Int, char: MMUnit) -> Int in
            return a + char.spd
            
        })
    }
    
    
    
    var characters = [MMUnit]()
    
    var guardians: [MMGuardian] = []
    
    
    
    
    
    init(key: String, characters: [MMUnit]) {
        self.key = key
        self.addCharacters(characters)
    }
    
    
    
    func addCharacter(_ character: MMUnit) {
        //        for char in self.characters {
        //            if char.key == character.key {
        //                return
        //            }
        //        }
        
        character._player = self
        self.characters.append(character)
    }
    
    
    func addCharacters(_ characters: [MMUnit]) {
        for char in characters {
            self.addCharacter(char)
        }
    }
    
    
    func reset() {
        for char in self.characters {
            char.isAttackedInCurrentRound = false
        }
    }
    
    
    
    
    
    
    var aliveCharacters: [MMUnit] {
        return self.characters.filter { $0.isAlive }
    }
    
    
    var nextAliveCharacter: MMUnit? {
        
        for char in self.characters {
            if char.isAlive && !char.isAttackedInCurrentRound {
                char.isAttackedInCurrentRound = true
                return char
            }
        }
        
        return nil
    }
    

    
    var hasAliveCharacter: Bool {
        for char in self.characters {
            if char.isAlive {
                return true
            }
        }
        
        return false
    }
    
    
    var json: JSON {
        
        let characters = self.aliveCharacters.map {
            return JSON($0.state)
        }
        
        
        let dict: [String: Any] = [kPlayerKey: self.key, kCharacters: characters]
        
        return JSON(dict)
        
//        let cards = JSON(characters.map{ $0.key })
//        let cells = JSON(characters.map{ $0.position })
//        let cardMaxHP = JSON(self.characters.map { $0.maxHP })
//        let cardHP = JSON(self.characters.map { $0.hp })
//        let cardMaxSP = JSON(self.characters.map { $0.maxSP })
//        let cardSP = JSON(self.characters.map { $0.sp })
//        
//        
//        return JSON(["playerkey": self.key,
//                     "cardkeys": cards,
//                     "cellids": cells,
//                     "maxhp": cardMaxHP,
//                     "hp": cardHP,
//                     "maxsp": cardMaxSP,
//                     "sp": cardSP])
        
    }
    
    
    
       
}



func ==(p1: MMBattlePlayer, _ p2: MMBattlePlayer) -> Bool {
    return p1.key == p2.key
}



class MMBattlePlayerAI: MMBattlePlayer {
    
    init() {
        super.init(key: "AI", characters: [])

    }
    
    static func rechargeCharacters(round: Int) -> [MMUnit] {
        return []
    }
    
    
    
}





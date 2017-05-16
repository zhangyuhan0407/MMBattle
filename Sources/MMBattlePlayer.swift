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
            return a + char.card.spd
            
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
        
        var ret = JSON([kPlayerKey: self.key])
        
        let characters = self.aliveCharacters.map {
            return JSON($0.state)
        }
        
        ret[kCharacters] = JSON(characters)
        
        return ret
        
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
    
    
    
    
    ///
    
    
    
//    func findMainTarget(damage: MMDamage) -> MMCharacter {
//        let player: MMBattlePlayer
//        
//        if damage.rule == .help || damage.rule == .current {
//            player = self
//        } else {
//            player = self.enemy
//        }
//        
//        let mainTarget: MMCharacter
//        switch damage.rule {
//        case .mostHP:
//            mainTarget = player.mostHPCharacter
//        case .fewerHP:
//            mainTarget = player.fewerHPCharacter
//        case .mostSP:
//            mainTarget = player.mostSPCharacters.last!
//        case .fewerSP:
//            mainTarget = player.fewerSPCharacters.last!
//        case .random:
//            mainTarget = player.characters[Int.random(max: player.characters.count)]
//        case .next:
//            
//            var temp = player.characters.last!
//            for char in player.characters {
//                if !char.isAttackedInCurrentRound {
//                    temp = char
//                }
//            }
//            
//            mainTarget = temp
//            
//        default:
//            mainTarget = player.findCharacters(inCells: AttackRule.find(position: damage.source.position, rule: damage.rule)).first ?? player.characters.first!
//
//        }
//        
//        //职责不清晰
//        //damage.destination = mainTarget
//        
//        return mainTarget
//    }
    
    
//    func findTargets(damage: MMDamage) -> [MMCharacter] {
//        let player: MMBattlePlayer
//        
//        if damage.rule == .help {
//            player = self
//        } else {
//            player = self.enemy
//        }
//        
//        return player.findCharacters(inCells: AttackArea.find(position: damage.destination!.position, area: damage.area))
//    }
    
       
}



func ==(p1: MMBattlePlayer, _ p2: MMBattlePlayer) -> Bool {
    return p1.key == p2.key
}



class MMBattlePlayerAI: MMBattlePlayer {
    
    init() {
        super.init(key: "AI", characters: [])
//        let player = MMPlayerRepo.findPlayer(key: "ai")
//        let cards = ["fs_bingshuang", "fs_aoshu", "sm_zengqiang", "sm_zhiliao", "sm_yuansu"]
//        let fabao = [JSON].init(repeating: JSON(""), count: 5)
//        let cells = [1, 3, 6, 11, 15]
//        let characters = MMCharacterRepo.create(cards: cards, fabaos: fabao, cells: cells)
//        super.init(player: player, characters: characters, guardian: [])
    }
    
    static func rechargeCharacters(round: Int) -> [MMUnit] {
        
//        if round == 3 {
////            let char = MMCharacter(card: MMCardRepo.findOne(key: "houyi"), fabao: MMFaBaoRepo.findOne(key: ""), position: 8)
//            return []
//        } else if round == 4 {
////            let char1 = MMCharacter(card: MMCardRepo.findOne(key: "houyi"), fabao: MMFaBaoRepo.findOne(key: ""), position: 8)
//            let char2 = MMCharacter(card: MMCardRepo.sharedInstance.cards["fs_aoshu"]!, fabao: MMFaBaoRepo.findOne(key: ""), position: 2)
//            return [char2]
//        } else if round == 2 {
////            let char1 = MMCharacter(card: MMCardRepo.findOne(key: "houyi"), fabao: MMFaBaoRepo.findOne(key: ""), position: 8)
////            let char2 = MMCharacter(card: MMCardRepo.findOne(key: "xingtian"), fabao: MMFaBaoRepo.findOne(key: ""), position: 2)
//            let char = MMCharacter(card: MMCardRepo.sharedInstance.cards["ms_shensheng"]!, fabao: MMFaBaoRepo.findOne(key: ""), position: 8)
//            let char3 = MMCharacter(card: MMCardRepo.sharedInstance.cards["ms_jielv"]!, fabao: MMFaBaoRepo.findOne(key: ""), position: 14)
//            return [char, char3]
//        }
        
        return []
    }
    
    
    
}





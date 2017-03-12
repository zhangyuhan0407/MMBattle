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
    
    weak var battle: MMBattle?
    
    var enemy: MMBattlePlayer {
        
        return self.battle!.enemy(forPlayer: self)
    }
    
    var record: MMBattleRecord {
        return self.battle!.record
    }
    
    
    
    var player: MMPlayer
    
    var key: String {
        return self.player.key
    }
    
    
    var speed: Int {
        return self.characters.reduce(0, { (a: Int, char: MMCharacter) -> Int in
            return a + char.card.spd
            
        })
    }
    
    
    
    var characters = [MMCharacter]()
    
    var guardians: [MMGuardian]
    
    
    
    
    
    
    
    var mostSPCharacters: [MMCharacter] {
        var ret = [MMCharacter]()
        for i in [5,4,3,2,1,0] {
            for char in self.aliveCharacters {
                if char.sp == i {
                    ret.append(char)
                }
            }
            if ret.count > 0 {
                return ret
            }
        }
        Logger.error("no characters")
        return []
    }
    
    
    var fewerSPCharacters: [MMCharacter] {
        var ret = [MMCharacter]()
        for i in 0...5 {
            for char in self.aliveCharacters {
                if char.sp == i {
                    ret.append(char)
                }
            }
            if ret.count > 0 {
                return ret
            }
        }
        Logger.error("no characters")
        return []
    }
    
    
    var mostHPCharacter: MMCharacter {
        var ret = self.aliveCharacters[0]
        for char in self.aliveCharacters {
            if char.hp >= ret.hp {
                ret = char
            }
        }
        return ret
    }
    
    
    var fewerHPCharacter: MMCharacter {
        var ret = self.aliveCharacters[0]
        for char in self.aliveCharacters {
            if char.hp <= ret.hp {
                ret = char
            }
        }
        return ret
    }
    
    
    var aliveCharacters: [MMCharacter] {
        return self.characters.filter { $0.isAlive }
    }
    
    
    var nextAliveCharacter: MMCharacter? {
        
        for char in self.characters {
            if char.isAlive && !char.isAttackedInCurrentRound {
                char.isAttackedInCurrentRound = true
                return char
            }
        }
        
        return nil
    }
    
    
    
    
    
    ///Func
    
    
    
    init(player: MMPlayer, characters: [MMCharacter], guardian: [MMGuardian]) {
        self.player = player
        self.guardians = guardian
        self.addCharacters(characters)
    }

    
    func addCharacter(_ character: MMCharacter) {
//        for char in self.characters {
//            if char.key == character.key {
//                return
//            }
//        }
        
        character.player = self
        self.characters.append(character)
    }
    
    
    func addCharacters(_ characters: [MMCharacter]) {
        for char in characters {
            self.addCharacter(char)
        }
    }
    
    
    func reset() {
        for char in self.characters {
            char.isAttackedInCurrentRound = false
        }
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
        
        let cards = JSON(characters.map{ $0.key })
        let cells = JSON(characters.map{ $0.position })
        let cardMaxHP = JSON(self.characters.map { $0.maxHP })
        let cardHP = JSON(self.characters.map { $0.hp })
        let cardMaxSP = JSON(self.characters.map { $0.maxSP })
        let cardSP = JSON(self.characters.map { $0.sp })
        
        
        return JSON(["playerkey": self.key,
                     "cardkeys": cards,
                     "cellids": cells,
                     "maxhp": cardMaxHP,
                     "hp": cardHP,
                     "maxsp": cardMaxSP,
                     "sp": cardSP])
        
    }
    
    
    
    
    ///
    
    
    
    func findMainTarget(damage: MMDamage) -> MMCharacter {
        let player: MMBattlePlayer
        
        if damage.rule == .help || damage.rule == .current {
            player = self
        } else {
            player = self.enemy
        }
        
        let mainTarget: MMCharacter
        switch damage.rule {
        case .mostHP:
            mainTarget = player.mostHPCharacter
        case .fewerHP:
            mainTarget = player.fewerHPCharacter
        case .mostSP:
            mainTarget = player.mostSPCharacters.last!
        case .fewerSP:
            mainTarget = player.fewerSPCharacters.last!
        case .random:
            mainTarget = player.characters[Int.random(max: player.characters.count)]
        case .next:
            
            var temp = player.characters.last!
            for char in player.characters {
                if !char.isAttackedInCurrentRound {
                    temp = char
                }
            }
            
            mainTarget = temp
            
        default:
            mainTarget = player.findCharacters(inCells: AttackRule.find(position: damage.source.position, rule: damage.rule)).first!

        }
        
        //职责不清晰
        //damage.destination = mainTarget
        
        return mainTarget
    }
    
    
    func findTargets(damage: MMDamage) -> [MMCharacter] {
        let player: MMBattlePlayer
        
        if damage.rule == .help {
            player = self
        } else {
            player = self.enemy
        }
        
        return player.findCharacters(inCells: AttackArea.find(position: damage.destination!.position, area: damage.area))
    }
    
    
    
    func act() {
        guard let char = self.nextAliveCharacter else {
            return
        }
        
        self.record.putFightState(MMFightState(fromCharacter: char))
        
        var damage = char.willHit()
        
        
        if damage.skillIndex == 0 {
            return
        }
        
        
        self.record.fightState.damage = damage
        
        
        let mainTarget = self.findMainTarget(damage: damage)
        damage.destination = mainTarget
        let targets = self.findTargets(damage: damage)
        

        char.setMainTarget(character: char, damage: damage)
        char.setSideTargets(character: char, damage: damage)
        
        
        
        self.record.fightState.targetPlayerKey = mainTarget.player!.key
        self.record.fightState.targetCardKey = mainTarget.key
        self.record.fightState.targetCellID = mainTarget.position
        
        
        
        char.hit(damage: damage, allTargets: targets)
        
        var damages = [MMDamage]()
        
        let tempDamage = damage.copy()
        
        for tar in targets {
            if tar.isAlive {
                let realDamage = tempDamage.copy()
                
                tar.willBehit(damage: realDamage)
                tar.behit(damage: realDamage)
                tar.didBehit(damage: realDamage)
                damages.append(realDamage)
                
                let affect = MMAffectState(playerKey: mainTarget.player!.key, damage: realDamage)
                self.record.putAffectState(affect)
                
                
                if tar.key == mainTarget.key {
                    damage = realDamage
                }
            }
        }
        
        
        
        char.didHit(mainTargetDamage: damage, allTargetDamages: damages)
        
        self.record.pushFightState()
        
    }
    
    
}



func ==(p1: MMBattlePlayer, _ p2: MMBattlePlayer) -> Bool {
    return p1.player.key == p2.player.key
}


extension MMBattlePlayer {
    
    
    func findCharacter(inCell cell: Int) -> MMCharacter? {
        for char in self.characters {
            if char.position == cell && char.hp > 0 {
                return char
            }
        }
        return nil
    }
    
    
    func findCharacters(inCells cells: [Int]) -> [MMCharacter] {
        var ret = [MMCharacter]()
        for cell in cells {
            for char in self.aliveCharacters {
                if char.position == cell {
                    ret.append(char); break
                }
            }
        }
        return ret
    }
    
    
}





class MMBattlePlayerAI: MMBattlePlayer {
    
    init() {
        let player = MMPlayerRepo.findPlayer(key: "ai")
        let characters = MMCharacterRepo.create(cards: ["xuanwu", "taotie", "fengbo", "fenghou", "suanyu"], fabaos: [], cells: [1, 3, 6, 11, 15])
        super.init(player: player, characters: characters, guardian: [])
    }
    
    static func rechargeCharacters(round: Int) -> [MMCharacter] {
        
        if round == 3 {
//            let char = MMCharacter(card: MMCardRepo.findOne(key: "houyi"), fabao: MMFaBaoRepo.findOne(key: ""), position: 8)
            return []
        } else if round == 4 {
//            let char1 = MMCharacter(card: MMCardRepo.findOne(key: "houyi"), fabao: MMFaBaoRepo.findOne(key: ""), position: 8)
            let char2 = MMCharacter(card: MMCardRepo.findOne(key: "xingtian"), fabao: MMFaBaoRepo.findOne(key: ""), position: 2)
            return [char2]
        } else if round == 2 {
//            let char1 = MMCharacter(card: MMCardRepo.findOne(key: "houyi"), fabao: MMFaBaoRepo.findOne(key: ""), position: 8)
//            let char2 = MMCharacter(card: MMCardRepo.findOne(key: "xingtian"), fabao: MMFaBaoRepo.findOne(key: ""), position: 2)
            let char = MMCharacter(card: MMCardRepo.findOne(key: "houyi"), fabao: MMFaBaoRepo.findOne(key: ""), position: 8)
            let char3 = MMCharacter(card: MMCardRepo.findOne(key: "change"), fabao: MMFaBaoRepo.findOne(key: ""), position: 14)
            return [char, char3]
        }
        
        return []
    }
    
    
    
}





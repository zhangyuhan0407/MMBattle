//
//  MMFengHou.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


//class MMFengHou: MMCard {
//    
//    override init() {
//        super.init()
//        
//        self.key = "fenghou"
//        self.id = 7
//        self.name = "风后"
//        
//        self.attackRule = .melee
//        self.attackArea = .single
//        self.attackType = .physics
//        
//        
//        self.ball = Ball.tu.rawValue
//        self.category = CharacterCategory.help.rawValue
//        
//        
//        
//        self.sp = 1
//        self.hp = 100
//        self.atk = 40
//        self.def = 30
//        self.mag = 0
//        self.spd = 40
//        
//    }
//    
//    
//    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
//        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
//        
//        
//        let player = character.player!
//        
//        
//        if damage.skillIndex == 2 {
//            for char in player.aliveCharacters {
//                if char != character {
//                    char.sp += 1
//                    player.battle!.record.putAfterFight(char.createCustomAnimationDictionary(type: .changeSP))
//                }
//                
//                char.addBuff(MMBuffShiXue())
//                player.battle?.record.putAfterFight(char.createCustomAnimationDictionary(type: .addBuff(key: "shixue")))
//                
//            }
//        } else {
//            let cells = AttackArea.find(position: character.position, area: .nineCube)
//            let targets = player.findCharacters(inCells: cells)
//            for char in targets {
//                char.sp += 1
//                player.battle!.record.putAfterFight(char.createCustomAnimationDictionary(type: .changeSP))
//            }
//        }
//    }
//    
//}



class QSShenSheng: MMCard {
    
    override init() {
        super.init()
        
        self.key = "qs_zhiliao"
        self.id = 26
        self.name = "奶骑"

        self.attackType = .holy
        
        self.sp = 1
        self.hp = 100
        self.atk = 40
        self.def = 30
        self.mag = 0
        self.spd = 40
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.player.fewerHPCharacter
        return damage
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        super.didHit(character: character, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
        if let buff = mainDamage!.destination.buffs.last {
            mainDamage!.destination.removeBuff(buff)
            character.record.putAfterFight(mainDamage!.destination.createCustomAnimationDictionary(type: .removeBuff(key: buff.key)))
        }
        
        
    }
    
    
    
}


class QSChengJie: MMCard {
    
    override init() {
        super.init()
        
        self.key = "qs_chengjie"
        self.id = 27
        self.name = "惩戒骑"
        
        self.attackType = .holy
        
        self.sp = 1
        self.hp = 100
        self.atk = 40
        self.def = 30
        self.mag = 0
        self.spd = 40
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        
            let units = character.player.findCharacters(nineCubeInPosition: character.position)
            return units.map {
                let damage = character.createDamage()
                damage.destination = $0
                return damage
            }
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        mainDamage!.destination.sp += 1
        for damage in sideDamages {
            damage.destination.sp += 1
        }
        if skill.index == 2 {
            character.sp = 0
        }
    }
    
    
}



class QSFangYu: MMCard {
    override init() {
        super.init()
        
        self.key = "qs_fangyu"
        self.id = 28
        self.name = "防骑"

        self.attackType = .holy
        
        self.sp = 1
        self.hp = 100
        self.atk = 40
        self.def = 30
        self.mag = 0
        self.spd = 40
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
}









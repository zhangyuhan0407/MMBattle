//
//  MMFengHou.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


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
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        
        damage.value = -damage.value
    }
    
    override func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        damage.destination.hp -= damage.value
    }
    
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        super.didHit(character: character, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
//        if let buff = mainDamage!.destination.buffs.last {
//            mainDamage!.destination.removeBuff(buff)
//            character.record.putAfterFight(mainDamage!.destination.createCustomAnimationDictionary(type: .removeBuff(key: buff.key)))
//        }
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









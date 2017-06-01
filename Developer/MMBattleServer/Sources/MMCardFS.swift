//
//  MMSuanYu.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import OCTJSON
import OCTFoundation


class FSAoShu: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "fs_aoshu"
        self.id = 1
        self.name = "奥法"
        
        self.attackType = .arcane
        
        self.sp = 2
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 130
        self.spd = 30
        
    }
    
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage {
        let damage = character.createDamage()
        
        if skill.index == 1 {
            damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        } else {
            damage.destination = character.enemy.mostSPCharacters.last!
        }
        
        return damage
    }
    
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        let damage = mainDamage!
        
        if skill.index == 1 {
            character.sp += 1
            damage.destination.sp += 1
            
        } else {
            character.sp = 0
            
            damage.destination.addBuff(MMBuffChenMo())
            character.record.putAfterFight(damage.destination.createCustomAnimationDictionary(type: .addBuff(key: "chenmo")))
        }
        
    }
    
}


class FSBingShuang: MMCard {
    override init() {
        
        super.init()
        
        self.key = "fs_bingshuang"
        self.id = 2
        self.name = "冰法"
        
        self.attackType = .ice
        
        self.sp = 2
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 90
        self.spd = 30
        
        self.baoji = 30
        
    }
    
    
    override func createSkill(character: MMUnit) -> BTSkill {
        let skill = super.createSkill(character: character)
        
        if skill.index == 2 {
            skill.area = .side
        }
        
        return skill
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        if skill.index == 2 {
            return nil
        }
        
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        
        
        for unit in character.player.findAllUnits() {
            if unit.hasBuff("binghuan") {
                damage.destination = unit
                break
            }
            
        }
        
        return damage
        
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        }
        
        let units = character.enemy.findUnitsFrontRow()
        
        return units.map { unit in
            let damage = character.createDamage()
            damage.destination = unit
            return damage
        }
        
    }
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        
        if skill.index == 1 {
            if damage.destination.hasBuff("binghuan") {
                damage.value *= 2
            }
        }
        if skill.index == 2 {
            damage.value = 0
        }
        
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        
        if skill.index == 1 {
            character.sp += 1
        } else {
            character.sp = 0
            for damage in sideDamages {
                damage.destination.addBuff(MMBuffBingHuan())
                character.record.putAfterFight(damage.destination.createCustomAnimationDictionary(type: .addBuff(key: "binghuan")))
            }
        }
        
    }
    
    
}



class FSHuoYan: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "fs_huoyan"
        self.id = 3
        self.name = "火法"
        
        self.attackType = .fire
        
        self.sp = 2
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 90
        self.spd = 30
        
        self.baoji = 30
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        
        return damage
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        let damage = mainDamage!
        if damage.isShanbi { return }
        
        if skill.index == 1 {
            character.sp += 1
            if damage.isBaoji {
                character.sp += 1
            }
        } else {
            character.sp = 0
        }
        
        damage.destination.sp += 1
        
    }
    
    
    
    
}













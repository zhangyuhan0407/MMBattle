//
//  MMHunDun.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation



class MMNPCUnit: MMCard {
    
    init(card: String, level: Int) {
        super.init()
        
        self.key = "npc_\(card)_\(level)"
        self.id = 100
        self.name = "我是一个NPC"
        
        self.attackType = .physics
        
        self.sp = 0
        self.hp = 100 * level
        self.atk = 40
        self.def = 30
        self.mag = 0
        self.spd = 40
        
    }
    
    
    override func createSkill(character: MMUnit) -> BTSkill {
        let skill = BTSkill(unit: character)
        skill.index = 1
        skill.type = self.attackType
        return skill
    }
    
    
}




class MMNPC_ZS: MMNPCUnit {
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
}


typealias MMNPC_DZ = MMNPC_ZS


class MMNPC_LR: MMNPCUnit {
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        return damage
    }
}


class MMNPC_FS: MMNPCUnit {
    override init(card: String, level: Int) {
        super.init(card: card, level: level)
        self.attackType = .fire
    }
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        return damage
    }
}













//
//  MMHunDun.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation



class MMNPCUnit: MMCard {
    
    init(key: String) {
        super.init()
        
        self.key = key
        self.id = 100
        self.name = "我是一个NPC"
        
        self.attackType = .physics
        
        self.sp = 0
        self.hp = 100
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



class MMNPC_LR: MMNPCUnit {
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        return damage
    }
}


class MMNPC_FS: MMNPCUnit {
    override init(key: String) {
        super.init(key: key)
        self.attackType = .fire
    }
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        return damage
    }
}



typealias MMNPC_DZ = MMNPC_ZS
typealias MMNPC_MS = MSShenSheng
typealias MMNPC_SS = MMNPC_FS
typealias MMNPC_XD = MMNPC_DZ
typealias MMNPC_SM = SMYuanSu
typealias MMNPC_QS = MMNPC_ZS










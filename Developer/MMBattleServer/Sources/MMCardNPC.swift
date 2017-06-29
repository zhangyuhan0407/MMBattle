//
//  MMHunDun.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation



class MMNPCUnit: MMCard {

    override func createSkill(character: MMUnit) -> BTSkill {
        let skill = BTSkill(unit: character)
        skill.index = 1
        skill.type = character.attackType
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










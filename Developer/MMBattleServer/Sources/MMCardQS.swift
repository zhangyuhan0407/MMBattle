//
//  MMFengHou.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class QSShenSheng: MMCard {
 
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
    
    
}


class QSChengJie: MMCard {
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        damage.userInfo["type"] = "main"
        return damage
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        
        let units = character.player.findCharacters(nineCubeInPosition: character.position)
        return units.map {
            let damage = character.createDamage()
            damage.destination = $0
            damage.userInfo["type"] = "side"
            return damage
        }
        
    }
    
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        
        let type = damage.userInfo["type"] as! String
        
        if type == "side" {
            if skill.index == 1 {
                damage.value = 0
            }
            else {
                damage.value = -damage.value
            }
        
        }
        
        
    }

    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        if mainDamage!.isShanbi == false {
            mainDamage!.destination.sp += 1    
        }
        
        
        for damage in sideDamages {
            damage.destination.sp += 1
        }
        if skill.index == 2 {
            character.sp = 0
        }
    }
    
    
}



class QSFangYu: MMCard {

    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
}









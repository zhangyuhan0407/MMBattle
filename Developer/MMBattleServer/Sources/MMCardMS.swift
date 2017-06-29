//
//  MMChangE.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MSShenSheng: MMCard {
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        
        return character.player.aliveCharacters.map { char in
            let damage = character.createDamage()
            damage.destination = char
            return damage
        }
        
    }
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        
        damage.value = -damage.value
    }
    
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        
        if skill.index == 1 {
            
        } else {
            character.sp = 0
        }
        
    }
    
}


class MSJieLv: MMCard {
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.player.randomUnit
        return damage
    }
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        
        
        
        if skill.index == 2 {
            damage.userInfo["healvalue"] = damage.value
        }
        
        damage.value = 0
    }
    
    
    override func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        damage.destination.sp += 10
    }
    
    
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        if skill.index == 1 {
            character.sp += 1
        } else {
            character.sp = 0
            mainDamage!.destination.addBuff(MMBuffDun(value: mainDamage!.userInfo["healvalue"] as! Int))
            character.record.putAfterFight(mainDamage!.destination.createCustomAnimationDictionary(type: .addBuff(key: "dun")))
        }
    }
    
    
    
}


class MSAnYing: MMCard {
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        
        if skill.index == 1 {
            damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        } else {
            damage.destination = character.enemy.mostSPCharacters.first!
        }
        
        return damage
    }
    
    
    override func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        if damage.isShanbi { return }
        
        
        damage.destination.hp -= damage.value
        
        if skill.index == 1 {
            damage.destination.sp -= 1
        } else {
            damage.userInfo["destsp"] = damage.destination.sp
            damage.destination.sp = 0
        }
        
    }
    
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        let damage = mainDamage!
        
        if skill.index == 1 {
            if damage.isShanbi { return }
            character.sp += 1
        } else {
            if damage.isShanbi {
                character.sp = 0
                return
            }
            character.sp = mainDamage!.userInfo["destsp"] as! Int
        }
    }
    
}










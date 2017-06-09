//
//  MMXuanWu.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class ZSWuQi: MMCard {
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        super.didHit(character: character, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
        
        if skill.index == 2 {
            let damage = mainDamage!
            damage.destination.addBuff(MMBuffZhiSiDaJi())
            character.record.putAfterFight(damage.destination.createCustomAnimationDictionary(type: .addBuff(key: "zhisidaji")))
        }
        
    }
}



class ZSKuangBao: MMCard {
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        skill.mainDamage = damage
        return damage
    }
    
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        }
        else {
            var units = character.enemy.findUnitsInRow(inPosition: skill.mainDamage!.destination.position)
            units = units.filter { $0.position != skill.mainDamage!.destination.position }
            return units.map {
                let damage = character.createDamage()
                damage.destination = $0
                return damage
            }
        }
    }
    
    
}



class ZSFangYu: MMCard {
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        
        let damage = character.createDamage()
        
        if skill.index == 1 {
            damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        }
        
        else {
            damage.destination = character
        }
        
        return damage
    }
    
    
    override func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        if skill.index == 1 {
            damage.destination.hp -= damage.value
            damage.destination.sp += 1
        }
        else {
            
        }
    }
    
    
    override func behit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        if damage.destination.hasBuff("dunqiang") {
            if skill.type == .physics {
                damage.value = damage.value.multiply(0.4)
            }
        }
    }
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        if skill.index == 1 {
            character.sp += 1
        }
        else {
            character.sp = 0
            character.addBuff(MMBuffDunQiang())
            character.record.putAfterFight(character.createCustomAnimationDictionary(type: .addBuff(key: "dunqiang")))
        }
    }
    
}


















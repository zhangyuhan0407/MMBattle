//
//  MMHouYi.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class XDXiong: MMCard {
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
    
}


class XDMao: MMCard {
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.aliveCharacters.last!
        return damage
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        super.didHit(character: character, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
        if skill.index == 2 {
            mainDamage!.destination.addBuff(MMBuffXuanYun())
            character.record.putAfterFight(mainDamage!.destination.createCustomAnimationDictionary(type: .addBuff(key: "xuanyun")))
        }
        
    }
    
}


class XDZhiLiao: MMCard {
    

    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        if skill.index == 1 {
            let damage = character.createDamage()
            damage.destination = character.player.randomUnit
            return damage
        }
        else {
            return nil
        }
    }
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        }
        else {
            let units = character.player.randomUnits(count: 3)
            return units.map {
                let damage = character.createDamage()
                damage.destination = $0
                return damage
            }
        }
    }
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        damage.value = -damage.value
    }
    
}



class XDNiao: MMCard {
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        return damage
    }
    
    
    
}





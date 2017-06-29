//
//  MMFengHuang.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation


class DZCiSha: MMCard {

    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
    
    
}


class DZZhanDou: MMCard {
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        } else {
            var damages = [MMDamage]()
            for _ in 0..<3 {
                if character.enemy.hasAliveCharacter {
                    let damage = character.createDamage()
                    damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
                    damages.append(damage)
                }
            }
            return damages
        }
    }
    
    
    
}



class DZMinRui: MMCard {
 
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.fewerHPCharacter
        return damage
    }
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        if skill.index == 2 {
            damage.userInfo["originalbaoji"] = character.baoji
            character.baoji = 10000
        }
    }
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        super.didHit(character: character, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
        if skill.index == 2 {
            character.baoji = mainDamage!.userInfo["originalbaoji"] as! Int
        }
    }
    
}















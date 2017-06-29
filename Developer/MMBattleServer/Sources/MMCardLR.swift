//
//  MMTaoTie.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class LRShengCun: MMCard {
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        skill.userinfo["mainTargetPosition"] = damage.destination.position
        return damage
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        } else {
            let position = skill.userinfo["mainTargetPosition"] as! Int
            return character.enemy.findCharacters(nineCubeInPosition: position).map { unit in
                let damage = character.createDamage()
                damage.destination = unit
                return damage
            }
        }
    }
    
    
    override func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        if skill.index == 1 {
            damage.destination.sp += 1
        }
        else {
            damage.destination.sp -= 1
        }
        
        damage.destination.hp -= damage.value
    }

    
//    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
//        if skill.index == 1 {
//            super.didHit(character: character, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
//        } else {
//            character.sp = 0
//            mainDamage!.destination.sp -= 1
//            for damage in sideDamages {
//                damage.destination.sp -= 1
//            }
//        }
//    }
    
    
}


class LRSheJi: MMCard {

    override func createSkill(character: MMUnit) -> BTSkill {
        let skill = super.createSkill(character: character)
        if skill.index == 1 {
            if OORandom.happens(inPosibility: 50) {
                skill.userinfo["islianji"] = true
            }
        }
        return skill
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        skill.mainDamage = damage
        return damage
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            if let _ = skill.userinfo["islianji"] as? Bool {
                let damage = character.createDamage()
                damage.destination = skill.mainDamage!.destination
                return [damage]
            } else {
                return []
            }
        } else {
            let position = skill.mainDamage!.destination.position
            return character.enemy.findUnitsInColumn(inPosition: position).filter {
                $0.position != position
                }.map { unit in
                    let damage = character.createDamage()
                    damage.destination = unit
                    return damage
                }
            
        }
    }
    
    
    
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        super.didHit(character: character, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
        if skill.index == 1 {
            if let _ = skill.userinfo["islianji"] as? Bool {
                character.sp += 1
            }
        }
    }
    
    
    
    
}

class  LRShouWang: MMCard {

    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        if skill.index == 1 {
            let damage = character.createDamage()
            damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
            return damage
        } else {
            let damage = character.createDamage()
            damage.destination = character.enemy.fewerDefUnit
            return damage
        }
        
    }
    
    
    
    
}











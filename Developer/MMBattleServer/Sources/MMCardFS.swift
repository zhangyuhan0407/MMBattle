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
            if damage.isShanbi {
                return
            }
            character.sp += 1
            damage.destination.sp += 1
            
        } else {
            character.sp = 0
            if damage.isShanbi {
                return
            }
            damage.destination.addBuff(MMBuffChenMo())
            character.record.putAfterFight(damage.destination.createCustomAnimationDictionary(type: .addBuff(key: "chenmo")))
        }
        
    }
    
}


class FSBingShuang: MMCard {
    
    override func createSkill(character: MMUnit) -> BTSkill {
        let skill = super.createSkill(character: character)
        
        if skill.index == 2 {
            skill.area = .side
        }
        
        return skill
    }
    
    
    /*
     
     
     冰法
     override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
     
     ////        if skill.index == 2 {
     ////            return nil
     ////        }
     //
     //        let damage = character.createDamage()
     //        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
     //
     //
     //        for unit in character.player.findAllUnits() {
     //            if unit.hasBuff("binghuan") {
     //                damage.destination = unit
     //                break
     //            }
     //
     //        }
     
     return damage
     
     }
     
     */
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        
        skill.mainDamage = damage
        return damage
    }

    
    
    /*
    
//    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
//        if skill.index == 1 {
//            return []
//        }
//        
//        let units = character.enemy.findUnitsFrontRow()
//        
//        return units.map { unit in
//            let damage = character.createDamage()
//            damage.destination = unit
//            return damage
//        }
//        
//    }
     
     
 */
    
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        }
        
        else {
            
            var units = character.enemy.findUnitsInRow(inPosition: skill.mainDamage!.destination.position)
            
            units = units.filter {
                $0.position != skill.mainDamage!.destination.position
            }
            
            return units.map {
                let damage = character.createDamage()
                damage.destination = $0
                return damage
            }
            
        }
        
    }
    
    
    
//    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
//        super.hit(character: character, skill: skill, damage: damage)
//        
//        if skill.index == 1 {
//            if damage.destination.hasBuff("binghuan") {
//                damage.value *= 2
//            }
//        }
//        if skill.index == 2 {
//            damage.value = 0
//        }
//        
//    }
    
    
//    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
//        
//        if skill.index == 1 {
//            character.sp += 1
//        } else {
//            character.sp = 0
//            for damage in sideDamages {
//                damage.destination.addBuff(MMBuffBingHuan())
//                character.record.putAfterFight(damage.destination.createCustomAnimationDictionary(type: .addBuff(key: "binghuan")))
//            }
//        }
//        
//    }
    
    
}



class FSHuoYan: MMCard {
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        
        return damage
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        let damage = mainDamage!
        
        if skill.index == 1 {
            if damage.isShanbi { return }
            
            character.sp += 1
            if damage.isBaoji {
                character.sp += 1
            }
        } else {
            character.sp = 0
            if damage.isShanbi { return }
        }
        
        damage.destination.sp += 1
        
    }
    
    
    
    
}



















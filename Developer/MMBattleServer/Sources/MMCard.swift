
//
//  File.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/20/16.
//
//


import Foundation
import OCTJSON
import OCTFoundation


class MMCard {
    
    var key: String!
    var id: Int!
    
    
    init() {
        
    }
    
    
    func createSkill(character: MMUnit) -> BTSkill {
        let skill = BTSkill(unit: character)
        if character.sp >= character.maxSP {
            skill.index = 2
        } else {
            skill.index = 1
        }
        skill.type = character.attackType
        return skill
    }
    
    
    func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        return nil
    }
    
    
    func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        return []
    }
    
    
    
    func willHit(character: MMUnit) {

    }

    
    
    func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        if skill.index == 1 {
            damage.value = character.atk * character.skill1Factor / 100
        } else if skill.index == 2 {
            damage.value = character.atk * character.skill2Factor / 100
        }
        
        if damage.value >= 100 {
            fatalError()
        }
        
    }
    
    
    func willBehit(character: MMUnit, skill: BTSkill) {
        
    }
    
    
    func behit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        
        _ = makeCalculatedValue(damage: damage, char1: damage.source, char2: damage.destination)
        
        
    }
    
    
    func didBehit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        
    }
    
    
    func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        if damage.isShanbi {
            return
        }
        damage.destination.hp -= damage.value
        damage.destination.sp += 1
        
    }
    
    
    
    //zyh!! shanbi do not increase sp
    func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        var shouldIncreaseSP = false
        
        for damage in sideDamages {
            if damage.isShanbi == false {
                shouldIncreaseSP = true
            }
        }
        
        if mainDamage != nil {
            if mainDamage!.isShanbi == false {
                shouldIncreaseSP = true
            }
        }
        
        
        
        if skill.index == 1 {
            if !shouldIncreaseSP { return }
            character.sp += 1
        } else if skill.index == 2 {
            character.sp = 0
        }
        
    }
    
    
    
    
}



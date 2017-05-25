
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
    var name: String!
    
//    var attackRule: AttackRule = .melee
//    var attackArea: AttackArea = .single
    var attackType: MMAttackType = .none
    
    
    var skill1Factor: Int = 50
    var skill2Factor: Int = 150
    

    
    var sp: Int = 5
    var hp: Int = 100
    var atk: Int = 100
    var def: Int = 100
    var mag: Int = 100
    var spd: Int = 100
    
    var baoji: Int = 0
    var shanbi: Int = 0
    var mingzhong: Int = 0
    var gedang: Int = 0
    
    
    var zaisheng: Int = 0
    var xixue: Int = 0
    var fantanwuli: Int = 0
    var fantanfashu: Int = 0
    
    init() {
        
    }
    
    
    func createSkill(character: MMUnit) -> BTSkill {
        let skill = BTSkill(unit: character)
        if character.sp >= self.sp {
            skill.index = 2
        } else {
            skill.index = 1
        }
        skill.type = character.card.attackType
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
            damage.value = skill1Factor
        } else if skill.index == 2 {
            damage.value = skill2Factor
        }
    }
    
    
    func willBehit(character: MMUnit, skill: BTSkill) {
        
    }
    
    
    func behit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        character.hp -= damage.value
    }
    
    
    func didBehit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        
    }
    
    
    //zyh!! shanbi do not increase sp
    func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        if skill.index == 1 {
            character.sp += 1
        } else if skill.index == 2 {
            character.sp = 0
        }
        
        mainDamage?.destination.sp += 1
        for damage in sideDamages {
            damage.destination.sp += 1
        }
        
    }
    
    
    
    
}



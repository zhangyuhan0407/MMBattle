//
//  MMCharacter+LifeCycle.swift
//  AAA
//
//  Created by yuhan zhang on 10/29/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


extension MMUnit {
    
    
    func createDamage() -> MMDamage {
        
        let damage = MMDamage(source: self)
        
//        if self.hasBuff("xuanyun") {
//            damage.skillIndex = 0
//            return damage
//        } else if self.sp >= self.maxSP && self.hasBuff("chenmo") {
//            damage.skillIndex = 0
//            return damage
//        } else if self.sp < self.maxSP && self.hasBuff("binghuan") {
//            damage.skillIndex = 0
//            return damage
//        }
        
        
//        damage.rule = card.attackRule
//        damage.type = card.attackType
        
        
//        if self.sp >= self.maxSP && !self.hasBuff("fengyin") {
//            damage.skillIndex = 2
//            damage.area = card.attackArea
//        }
//        damage.type = self.card.attackType
        
        
        switch damage.type {
        case .physics:
            damage.value = makeAttackValue(forCharacter: self)
//        case .magic:
//            damage.value = makeMagicValue(forCharacter: self)
//        case .real:
//            damage.value = makeRealValue(forCharacter: self)
//        case .heal:
//            damage.value = makeHealValue(forCharacter: self)
//        case .demoralize:
//            damage.value = makeRealValue(forCharacter: self)
//        case .poisonous:
//            damage.value = makeMagicValue(forCharacter: self)
//        case .vulnerable:
//            damage.value = makeMagicValue(forCharacter: self)
        default:
            damage.value = makeMagicValue(forCharacter: self)
        }
        
        
        return damage
        
    }
    
    
    func createSkill() -> BTSkill {
        let skill = card.createSkill(character: self)
        
        
        if self.attackType == .physics {
            if self.hasBuff("binghuan") {
                skill.index = 0
            }
        } else {
            if self.hasBuff("chenmo") {
                skill.index = 0
            }
        }
        
        if self.hasBuff("xuanyun") {
            skill.index = 0
        }
        
        
        if self.isAlive == false {
            skill.index = 0
        }
        
        return skill
    }
    
    
    func createMainTargetDamage(skill: BTSkill) -> MMDamage? {
        return card.createMainDamage(character: self, skill: skill)
    }
    
    
    func createSideTargetDamages(skill: BTSkill) -> [MMDamage] {
        return card.createSideDamages(character: self, skill: skill)
    }
    
    
    
    
    func willHit() {
        
//        handleZaiSheng()
        
        for buff in self.buffs {
            buff.willHit(character: self)
        }
        
        card.willHit(character: self)

    }
    
    
    func hit(skill: BTSkill, damage: MMDamage) {
        
        card.hit(character: self, skill: skill, damage: damage)
//        handleXixue(damage: damage)
        
    }
    
    
    func didHit(skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        for buff in self.buffs {
            buff.didHit(character: self, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        }

        card.didHit(character: self, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
    }
    
    
    
    
    func willBehit(skill: BTSkill) {
        
        for buff in self.buffs {
            buff.willBehit(character: self, skill: skill)
        }
        

        card.willBehit(character: self, skill: skill)
        
    }
    
    
    func behit(skill: BTSkill, damage: MMDamage) {

        card.behit(character: self, skill: skill, damage: damage)
        
    }
    
    
    func didBehit(skill: BTSkill, damage: MMDamage) {
        for buff in self.buffs {
            buff.didBehit(character: self, skill: skill, damage: damage)
        }
        
        card.didBehit(character: self, skill: skill, damage: damage)
//        handleFanTanWuLi(damage: damage)
//        handleFanTanFaShu(damage: damage)
    }
    
    

}

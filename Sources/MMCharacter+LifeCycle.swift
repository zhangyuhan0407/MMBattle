//
//  MMCharacter+LifeCycle.swift
//  AAA
//
//  Created by yuhan zhang on 10/29/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


extension MMCharacter {
    
    
    func createDamage() -> MMDamage {
        
        let damage = MMDamage(source: self)
        
        if self.hasBuff("xuanyun") {
            damage.skillIndex = 0
            return damage
        } else if self.sp >= self.maxSP && self.hasBuff("chenmo") {
            damage.skillIndex = 0
            return damage
        } else if self.sp < self.maxSP && self.hasBuff("binghuan") {
            damage.skillIndex = 0
            return damage
        }
        
        
        damage.rule = card.attackRule
        damage.type = card.attackType
        
        
        if self.sp >= self.maxSP && !self.hasBuff("fengyin") {
            damage.skillIndex = 2
            damage.area = card.attackArea
        }
        
        
        switch damage.type {
        case .physics:
            damage.value = makeAttackValue(forCharacter: self)
        case .magic:
            damage.value = makeMagicValue(forCharacter: self)
        case .real:
            damage.value = makeRealValue(forCharacter: self)
        case .heal:
            damage.value = makeHealValue(forCharacter: self)
        case .demoralize:
            damage.value = makeRealValue(forCharacter: self)
        case .poisonous:
            damage.value = makeMagicValue(forCharacter: self)
        case .vulnerable:
            damage.value = makeMagicValue(forCharacter: self)
        }
        return damage
    }
    
    
    func setMainTarget(character: MMCharacter, damage: MMDamage) {
        damage.destination = nil
    }
    
    func setSideTargets(character: MMCharacter, damage: MMDamage) {
        damage.sideTargets = nil
    }
    
    
    
    
    func willHit() -> MMDamage {
        let damage = self.createDamage()
        
//        self.fabao.will
        
        for buff in self.buffs {
            buff.willHit(character: self, damage: damage)
        }
        
        handleZaiSheng()
        
        card.willHit(character: self, damage: damage)
        
        return damage
    }
    
    
    func hit(damage: MMDamage, allTargets: [MMCharacter]) {
        
        if damage.skillIndex == 0 {
            return
        }
        
        card.hit(character: self, damage: damage, allTargets: allTargets)
        handleXixue(damage: damage)
        
    }
    
    
    func didHit(mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        for buff in self.buffs {
            buff.didHit(character: self, mainTargetDamage: damage)
        }

        card.didHit(character: self, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
        
    }
    
    
    
    
    func willBehit(damage: MMDamage) {
        damage.destination = self
        
        
        for buff in self.buffs {
            buff.willBehit(character: self, damage: damage)
        }
        

        card.willBehit(character: self, damage: damage)
        
    }
    
    
    func behit(damage: MMDamage) {

        card.behit(character: self, damage: damage)
        handleFanTanWuLi(damage: damage)
        handleFanTanFaShu(damage: damage)
        
    }
    
    
    func didBehit(damage: MMDamage) {
        for buff in self.buffs {
            buff.didBehit(character: self, damage: damage)
        }
        
        card.didBehit(character: self, damage: damage)
        
    }
    
    

}

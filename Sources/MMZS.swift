//
//  MMXuanWu.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class ZSWuQi: MMCard {
    
    override init() {
        super.init()
        
        self.key = "zs_wuqi"
        self.id = 23
        self.name = "武器战"
        
        self.attackType = .physics
        
        self.sp = 3
        self.hp = 100
        self.atk = 10
        self.def = 40
        self.mag = 10
        self.spd = 0
        
        
    }
    
    
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
    
    override init() {
        super.init()
        
        self.key = "zs_kuangbao"
        self.id = 24
        self.name = "狂暴战"

        self.attackType = .physics
        
        self.sp = 3
        self.hp = 100
        self.atk = 10
        self.def = 40
        self.mag = 10
        self.spd = 0
        
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
    
    
}



class ZSFangYu: MMCard {
    
    override init() {
        super.init()
        
        self.key = "zs_fangyu"
        self.id = 25
        self.name = "防战"

        self.attackType = .physics
        
        self.sp = 3
        self.hp = 100
        self.atk = 10
        self.def = 40
        self.mag = 10
        self.spd = 0
        
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        if skill.index == 1 {
            let damage = character.createDamage()
            damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
            return damage
        } else {
            return nil
        }
    }
    
    
    override func behit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        if damage.destination.hasBuff("dunqiang") {
            if skill.type == .physics {
                damage.value = damage.value.multiply(0.4)
            }
        }
        super.behit(character: character, skill: skill, damage: damage)
    }
    
}


















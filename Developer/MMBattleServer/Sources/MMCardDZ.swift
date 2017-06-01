//
//  MMFengHuang.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation


class DZCiSha: MMCard {
    
    override init() {
        super.init()
        
        self.key = "dz_cisha"
        self.id = 10
        self.name = "刺杀贼"
        
        self.attackType = .physics
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 40
        self.spd = 60
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        return damage
    }
    
    
}


class DZZhanDou: MMCard {
    
    override init() {
        super.init()
        
        self.key = "dz_zhandou"
        self.id = 11
        self.name = "战斗贼"
        
        self.attackType = .physics
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 40
        self.spd = 60
        
    }
    
    
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
                let damage = character.createDamage()
                damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
                damages.append(damage)
            }
            return damages
        }
    }
    
    
    
}



class DZMinRui: MMCard {
    override init() {
        super.init()
        
        self.key = "dz_minrui"
        self.id = 12
        self.name = "敏锐贼"
        
        self.attackType = .physics
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 40
        self.spd = 60
        
    }
 
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















//
//  MMXingTian.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class SMZengQiang: MMCard {
    
    override init() {
        super.init()
        
        self.key = "sm_zengqiang"
        self.id = 20
        self.name = "增强萨"
        
        self.attackType = .lightning
        
        self.sp = 3
        self.hp = 100
        self.atk = 50
        self.def = 0
        self.mag = 0
        self.spd = 10
        
        
    }
    
    
    override func createSkill(character: MMUnit) -> BTSkill {
        let skill = super.createSkill(character: character)
        if skill.index == 1 {
            if OORandom.happens(inPosibility: 20) {
                skill.userinfo = [:]
                skill.userinfo["isfengnu"] = true
            }
        } else {
            skill.userinfo = [:]
            skill.userinfo["isfengnu"] = true
        }
        return skill
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findUnits(forMeleeAttack: character.position)
        skill.mainDamage = damage
        damage.userInfo["changesp"] = 1
        return damage
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        var damages = [MMDamage]()
        
        if let _ = skill.userinfo["isfengnu"] as? Bool {
            for _ in 0..<2 {
                let damage = character.createDamage()
                damage.value = skill2Factor
                damage.destination = skill.mainDamage!.destination
                damages.append(damage)
            }
            
        }
        return damages
    }
    
    
    
    override func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        let changeSP = damage.userInfo["changesp"] as? Int ?? 0
        
        damage.destination.sp += changeSP
        damage.destination.hp -= damage.value
    }
    
    
    
    
}


class SMYuanSu: MMCard {
    
    override init() {
        super.init()
        
        self.key = "sm_yuansu"
        self.id = 21
        self.name = "元素萨"
        
        self.attackType = .lightning
        
        self.sp = 3
        self.hp = 100
        self.atk = 50
        self.def = 0
        self.mag = 0
        self.spd = 10
        
        
    }
    
    
    override func createSkill(character: MMUnit) -> BTSkill {
        let skill = super.createSkill(character: character)
        if OORandom.happens(inPosibility: 20) {
            skill.userinfo["isguozai"] = true
        }
        return skill
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        skill.mainDamage = damage
        damage.userInfo["factor"] = Float(1)
        damage.userInfo["changesp"] = 1
        return damage
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        var damages = [MMDamage]()
        if skill.index == 1 {
            if let _ = skill.userinfo["isguozai"] as? Bool {
                let damage = character.createDamage()
                damage.userInfo["factor"] = Float(1)
                damage.destination = skill.mainDamage!.destination
            }
        } else {

            let units = character.enemy.randomUnits(count: 3).filter {
                $0.key != skill.mainDamage!.destination.key
            }
            
            
            var value: Float = 0.7
            for unit in units {
                let damage = character.createDamage()
                damage.destination = unit
                damage.userInfo["factor"] = value
                value *= value
                damages.append(damage)
            }            
            
            
            if let _ = skill.userinfo["isguozai"] as? Bool {
                var guozaiDamages = [MMDamage]()
                let damage = character.createDamage()
                damage.userInfo = skill.mainDamage!.userInfo
                damage.destination = skill.mainDamage!.destination
                guozaiDamages.append(damage)
                
                
                for d in damages {
                    let damage = character.createDamage()
                    damage.userInfo = d.userInfo
                    damage.destination = d.destination
                    guozaiDamages.append(d)
                }
                
                for d in guozaiDamages {
                    damages.append(d)
                }
            }
        }
        
        return damages
    }
    
    
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        damage.value = damage.value.multiply(damage.userInfo["factor"] as! Float)
    }
    
    
    override func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        let changeSP = damage.userInfo["changesp"] as? Int ?? 0
        
        damage.destination.sp += changeSP
        damage.destination.hp -= damage.value
    }
    
    
}


class SMZhiLiao: MMCard {
    
    override init() {
        super.init()
        
        self.key = "sm_huifu"
        self.id = 22
        self.name = "恢复萨"
        
        self.attackType = .nature
        
        self.sp = 3
        self.hp = 100
        self.atk = 50
        self.def = 0
        self.mag = 0
        self.spd = 10
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        if skill.index == 1 {
            let damage = character.createDamage()
            damage.destination = character.player.fewerHPCharacter
            return damage
        } else {
            return nil
        }
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        }
        else {
            return character.player.findAllUnits().map {
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
    
    
    override func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        damage.destination.hp -= damage.value
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        if skill.index == 1 {
            character.sp += 1
        }
        else {
            character.sp = 0
            for damage in sideDamages {
                damage.destination.sp += 1
                damage.destination.addBuff(MMBuffShiXue())
                character.record.putAfterFight(damage.destination.createCustomAnimationDictionary(type: .addBuff(key: "shixue")))
            }
        }
    }
    
    
}

















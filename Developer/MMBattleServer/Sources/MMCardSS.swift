//
//  MMFengBo.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class SSHuiMie: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "ss_huimie"
        self.id = 7
        self.name = "毁灭术"
        
        self.attackType = .fire
  
        self.sp = 2
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 90
        self.spd = 30
        
    }
    
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        if skill.index == 1 {
            let damage = character.createDamage()
            damage.destination = character.enemy.randomUnit
            return damage
        } else {
            return nil
        }
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        } else {
            return character.enemy.findAllUnits().map { unit in
                let damage = character.createDamage()
                damage.destination = unit
                return damage
            }
        }
    }
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        
        if skill.index == 1 {
            damage.addBuff(buff: "xianji")
        } else {
            for unit in character.enemy.findAllUnits() {
                if unit.hasBuff("xianji") {
                    damage.value *= 2
                }
            }
        }
        
    }
  
    
}



class SSTongKu: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "ss_tongku"
        self.id = 8
        self.name = "痛苦术"
        
        self.attackType = .evil
        
        self.sp = 2
        self.hp = 150
        self.atk = 0
        self.def = 0
        self.mag = 85
        self.spd = 30
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        if skill.index == 1 {
            let damage = character.createDamage()
            damage.destination = character.enemy.randomUnit
            return damage
        } else {
            return nil
        }
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        } else {
            let ret = character.enemy.findAllUnits().filter {
                $0.hasBuff("fushishu")
            }.map { char -> MMDamage in
                let damage = character.createDamage()
                damage.destination = char
                return damage
            }
            
             return ret
        }
    }
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        super.hit(character: character, skill: skill, damage: damage)
        
        damage.userInfo["value"] = damage.value
        
        damage.value = 0
        
    }
    
    override func valueHandler(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        if skill.index == 2 {
            for enemy in character.enemy.aliveCharacters {
                if enemy.hasBuff("fushishu") {
                    (enemy.findBuff("fushishu") as! MMBuffFuShiShu).validate()
                }
            }
        }
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        super.didHit(character: character, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        
        
        if skill.index == 1 {
            if mainDamage!.destination.hasBuff("fushishu") {
                (mainDamage!.destination.findBuff("fushishu") as! MMBuffFuShiShu).value += mainDamage!.userInfo["value"] as! Int
            } else {
                mainDamage!.destination.addBuff(MMBuffFuShiShu(value: mainDamage!.userInfo["value"] as! Int))
                character.record.putAfterFight(mainDamage!.destination.createCustomAnimationDictionary(type: .addBuff(key: "fushishu")))
            }
        }
        
    }
    
    
}



class SSEMo: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "ss_emo"
        self.id = 9
        self.name = "恶魔术"
       
        self.attackType = .evil
        
        self.sp = 5
        self.hp = 150
        self.atk = 0
        self.def = 0
        self.mag = 85
        self.spd = 30
        
    }
    
    
    override func createSkill(character: MMUnit) -> BTSkill {
        let skill = BTSkill(unit: character)
        
        let isBianshen = character.userinfo["isbianshen"] as? Bool ?? false
        if isBianshen {
            if character.sp >= 2 {
                skill.index = 3
                skill.type = .evil
            } else {
                skill.index = 1
                skill.type = .evil
                character.removeBuff(character.findBuff("emoxingtai")!)
                character.record.putBeforeFight(character.createCustomAnimationDictionary(type: CustomAnimation.removeBuff(key: "emoxingtai")))
            }
        } else {
            if character.sp >= self.sp {
                skill.index = 2
                character.addBuff(MMBuffEmoXingTai())
                character.record.putBeforeFight(character.createCustomAnimationDictionary(type: CustomAnimation.addBuff(key: "emoxingtai")))
            } else {
                skill.index = 1
                skill.type = .evil
            }
        }
        
        
        return skill
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        if skill.index == 1 {
            let damage = character.createDamage()
            damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
            return damage
        }
        else {
            return nil
        }
    }
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        if skill.index == 1 {
            return []
        }
        else if skill.index == 2 {
            return []
        }
        else {
            return character.enemy.findUnitsFrontRow().map { unit in
                let damage = character.createDamage()
                damage.destination = unit
                return damage
            }
        }
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        if skill.index == 1 {
            character.sp += 1
            mainDamage!.destination.sp += 1
        } else if skill.index == 2 {
            
        } else {
            character.sp -= 2
            for damage in sideDamages {
                damage.destination.sp += 1
            }
        }
    }
    
    
}








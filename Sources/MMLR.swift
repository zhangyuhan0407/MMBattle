//
//  MMTaoTie.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


//class MMTaoTie: MMCard {
//    
//    override init() {
//        super.init()
//        
//        self.key = "taotie"
//        self.id = 3
//        self.name = "饕餮"
//        
//        self.attackRule = .range
//        self.attackArea = .nineCube
//        self.attackType = .demoralize
//        
//        
//        self.ball = Ball.huo.rawValue
//        self.category = CharacterCategory.disabler.rawValue
//        
//
//        
//        self.sp = 2
//        self.hp = 100
//        self.atk = 20
//        self.def = 0
//        self.mag = 0
//        self.spd = 30
//        
////        self.xixue = 0
//    }
//    
//    override func willHit(character: MMCharacter, damage: MMDamage) {
//        if damage.skillIndex == 1 {
//            damage.rule = .melee
//        }
//    }
//    
//    
//    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
//        if damage.skillIndex == 1 {
//            character.sp += 1
//        } else {
//            character.sp = 0
//        }
//        
//        for tar in allTargets {
//            tar.sp -= 1
//        }
//        
//    }
//    
//}



class LRShengCun: MMCard {
    
    
    override init() {
        super.init()
        
        self.key = "lr_shengcun"
        self.id = 17
        self.name = "生存猎"
        
        self.attackType = .physics
        
        self.sp = 2
        self.hp = 100
        self.atk = 20
        self.def = 0
        self.mag = 0
        self.spd = 30
        
    }
    
    
    
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

    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        if skill.index == 1 {
            super.didHit(character: character, skill: skill, mainDamage: mainDamage, sideDamages: sideDamages)
        } else {
            character.sp = 0
            mainDamage!.destination.sp -= 1
            for damage in sideDamages {
                damage.destination.sp -= 1
            }
        }
    }
    
    
}


class LRSheJi: MMCard {
    
    override init() {
        super.init()
        
        self.key = "lr_sheji"
        self.id = 18
        self.name = "射击猎"
        
        self.attackType = .physics
        
        self.sp = 3
        self.hp = 100
        self.atk = 20
        self.def = 0
        self.mag = 0
        self.spd = 30
        
    }
    
    
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
    
    override init() {
        super.init()
        
        self.key = "lr_shouwang"
        self.id = 19
        self.name = "兽王猎"
      
        self.sp = 2
        self.hp = 100
        self.atk = 20
        self.def = 0
        self.mag = 0
        self.spd = 30
        
    }
    
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











//
//  MMChangE.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation



//class MMChangE: MMCard {
//    
//    
//    override init() {
//        super.init()
//        
//        self.key = "change"
//        self.id = 4
//        self.name = "嫦娥"
//        
//        self.ball = Ball.shui.rawValue
//        self.category = CharacterCategory.heal.rawValue
//        
//        self.attackRule = .help
//        self.attackArea = .all
//        self.attackType = .heal
//        
//        
//        self.sp = 1
//        self.hp = 100
//        self.atk = 0
//        self.def = 0
//        self.mag = 30
//        self.spd = 30
//        
//    }
//    
//    
//    override func willHit(character: MMCharacter, damage: MMDamage) {
//        if damage.skillIndex == 1 {
//            damage.area = .all
//            damage.value = 0
//        }
//    }
//    
//    
//    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
//        
//        if damage.skillIndex == 2{
//            character.sp = 0
//        }
//        
//    }
//    
//    
//    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
//        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
//        
//        
//        for tar in allTargetDamages {
//            tar.destination!.sp += 1
//            
//            character.player?.battle?.record.putAfterFight(tar.destination!.createCustomAnimationDictionary(type: .changeSP))
//        }
//    }
//    
//    
//}



class MSShenSheng: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "ms_shensheng"
        self.id = 4
        self.name = "神牧"
        
        self.attackType = .holy
        
        self.sp = 5
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 100
        self.spd = 30
        
    }
    
    
    
    override func createSideDamages(character: MMUnit, skill: BTSkill) -> [MMDamage] {
        
        return character.player.aliveCharacters.map { char in
            let damage = character.createDamage()
            damage.destination = character
            return damage
        }
        
    }
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        if skill.index == 1 {
            damage.value = 0
        }
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        
        if skill.index == 1 {
            character.sp += 1
        } else {
            character.sp = 0
        }
        
        
        for damage in sideDamages {
            if damage.destination.key == character.key {
                continue
            }
            damage.destination.sp += 1
            character.record.putAfterFight(damage.destination.createCustomAnimationDictionary(type: CustomAnimation.changeSP))
        }
        
    }
    
}


class MSJieLv: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "ms_jielv"
        self.id = 5
        self.name = "戒律牧"
        
        self.attackType = .holy
        
        self.sp = 5
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 85
        self.spd = 30
        
    }
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        damage.destination = character.player.randomUnit
        return damage
    }
    
    
    override func hit(character: MMUnit, skill: BTSkill, damage: MMDamage) {
        
        damage.destination.sp += 10
        
        if skill.index == 1 {
            damage.value = 0
        }
        
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        if skill.index == 1 {
            character.sp += 1
        } else {
            character.sp = 0
            mainDamage!.destination.addBuff(MMBuffDun(value: mainDamage!.value))
            character.record.putAfterFight(mainDamage!.destination.createCustomAnimationDictionary(type: .changeSP))
        }
    }
    
    
    
}


class MSAnYing: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "ms_anying"
        self.id = 9
        self.name = "暗牧"
        
        self.attackType = .shadow
        
        self.sp = 5
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 100
        self.spd = 30
        
    }
    
    
    
    override func createMainDamage(character: MMUnit, skill: BTSkill) -> MMDamage? {
        let damage = character.createDamage()
        
        if skill.index == 1 {
            damage.destination = character.enemy.findCharacter(forRangeAttack: character.position)
        } else {
            damage.destination = character.enemy.mostSPCharacters.first!
        }
        
        return damage
    }
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        let damage = mainDamage!
        if damage.isShanbi { return }
        
        if skill.index == 1 {
            damage.destination.sp -= 1
            character.sp += 1
        } else {
            let sp = damage.destination.sp
            character.sp = sp
            damage.destination.sp = 0
        }
    }
    
}










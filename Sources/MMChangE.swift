//
//  MMChangE.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


enum Ball: Int {
    case jin = 10000
    case mu = 1000
    case shui = 100
    case huo = 10
    case tu = 1
}


enum CharacterCategory: Int {
    case tank = 1
    case melee = 2
    case arrow = 3
    case magic = 4
    case heal = 5
    case disabler = 6
    case help = 7
}


class MMChangE: MMCard {
    
    override init() {
        super.init()
        
        self.key = "change"
        self.id = 4
        self.name = "嫦娥"
        
        self.ball = Ball.shui.rawValue
        self.category = CharacterCategory.heal.rawValue
        
        self.attackRule = .help
        self.attackArea = .all
        self.attackType = .heal
        
        
        self.sp = 1
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 30
        self.spd = 30
        
    }
    
    
    override func willHit(character: MMCharacter, damage: MMDamage) {
        if damage.skillIndex == 1 {
            damage.area = .all
            damage.value = 0
        }
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        
        if damage.skillIndex == 2{
            character.sp = 0
        }
        
    }
    
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
        
        
        for tar in allTargetDamages {
            tar.destination!.sp += 1
            
            character.player?.battle?.record.putAfterFight(tar.destination!.createCustomAnimationDictionary(type: .changeSP))
        }
    }
    
    
}



class MSShenSheng: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "shenmu"
        self.id = 7
        self.name = "神牧"
        
        self.attackRule = .range
        self.attackArea = .all
        self.attackType = .heal
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        //skill1Factor = 0.5
        
        
        self.sp = 5
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 100
        self.spd = 30
        
    }
    
    override func willHit(character: MMCharacter, damage: MMDamage) {
        if damage.skillIndex == 1 {
            damage.area = .all
            damage.value = 0
        }
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        
        if damage.skillIndex == 2{
            character.sp = 0
        }
        
    }
    
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
        
        
        for tar in allTargetDamages {
            tar.destination!.sp += 1
            
            character.player?.battle?.record.putAfterFight(tar.destination!.createCustomAnimationDictionary(type: .changeSP))
        }
    }
    
}


class MSJieLv: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "jielvmu"
        self.id = 8
        self.name = "戒律牧"
        
        self.attackRule = .random
        self.attackArea = .single
        self.attackType = .heal
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        
        self.sp = 5
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 85
        self.spd = 30
        
    }
    
    
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        damage.value = 0
        
        let tar = damage.destination!
        
        if damage.skillIndex == 1 {
            character.sp += 1
            tar.sp += 5
        } else {
            character.sp = 0
            tar.sp += 5
            tar.addBuff(MMBuffDun(value: character.mag))
        }
        
    }
    
    
    
    
    
}


class MSAnYing: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "anmu"
        self.id = 9
        self.name = "暗牧"
        
        self.attackRule = .range
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        
        self.sp = 5
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 100
        self.spd = 30
        
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        if damage.skillIndex == 1 {
            character.sp += 1
        } else {
            character.sp = damage.destination!.sp
            damage.destination!.sp = 0
        }
    }
    
    
}










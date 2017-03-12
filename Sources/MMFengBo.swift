//
//  MMFengBo.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMFengBo: MMCard {
    
    override init() {
        super.init()
        
        self.key = "fengbo"
        self.id = 6
        self.name = "风伯"
        
        self.attackRule = .range
        self.attackArea = .all
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.magic.rawValue
        
        
        
        self.sp = 5
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 50
        self.spd = 50
        
    }
    
    override func willHit(character: MMCharacter, damage: MMDamage) {
        if damage.skillIndex == 1 {
            damage.area = .row
        }
    }
    
}



class SSHuiMie: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "huimie"
        self.id = 3
        self.name = "毁灭术"
        
        self.attackRule = .range
        self.attackArea = .all
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        
        self.sp = 2
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 90
        self.spd = 30
        
    }
    
    
    
    
}



class SSTongKu: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "tongku"
        self.id = 4
        self.name = "痛苦术"
        
        self.attackRule = .range
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        
        self.sp = 2
        self.hp = 150
        self.atk = 0
        self.def = 0
        self.mag = 85
        self.spd = 30
        
    }
    
    
}


class SSEMo: MMCard {
    
    var isBianShen = false
    
    
    override init() {
        
        super.init()
        
        self.key = "emo"
        self.id = 6
        self.name = "恶魔术"
        
        self.attackRule = .range
        self.attackArea = .all
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        
        self.sp = 5
        self.hp = 150
        self.atk = 0
        self.def = 0
        self.mag = 85
        self.spd = 30
        
    }
    
    
    
    override func willHit(character: MMCharacter, damage: MMDamage) {
        
        if !self.isBianShen {
            if character.sp >= self.sp {
                self.isBianShen = true
                damage.skillIndex = 2
            }
            
        } else {
            if character.sp >= 2 {
                damage.skillIndex = 2
            } else {
                self.isBianShen = false
                damage.skillIndex = 1
            }
        }
        
        
        
    }
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        
        if damage.skillIndex == 1 {
            character.sp += 1
        } else {
            character.sp -= 2
        }
        
    }
    
    
    
}








//
//  MMTaoTie.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMTaoTie: MMCard {
    
    override init() {
        super.init()
        
        self.key = "taotie"
        self.id = 3
        self.name = "饕餮"
        
        self.attackRule = .range
        self.attackArea = .nineCube
        self.attackType = .demoralize
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.disabler.rawValue
        

        
        self.sp = 2
        self.hp = 100
        self.atk = 20
        self.def = 0
        self.mag = 0
        self.spd = 30
        
//        self.xixue = 0
    }
    
    override func willHit(character: MMCharacter, damage: MMDamage) {
        if damage.skillIndex == 1 {
            damage.rule = .melee
        }
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        if damage.skillIndex == 1 {
            character.sp += 1
        } else {
            character.sp = 0
        }
        
        for tar in allTargets {
            tar.sp -= 1
        }
        
    }
    
}



class LRShengCun: MMCard {
    
    
    override init() {
        super.init()
        
        self.key = "lr_shengcun"
        self.id = 3
        self.name = "生存猎"
        
        self.attackRule = .range
        self.attackArea = .nineCube
        self.attackType = .demoralize
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        self.sp = 2
        self.hp = 100
        self.atk = 20
        self.def = 0
        self.mag = 0
        self.spd = 30
        
    }
    
    
    override func willHit(character: MMCharacter, damage: MMDamage) {
        if damage.skillIndex == 1 {
            damage.rule = .melee
        }
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        if damage.skillIndex == 1 {
            character.sp += 1
        } else {
            character.sp = 0
        }
        
        for tar in allTargets {
            tar.sp -= 1
        }
        
    }
    
}


class LRSheJi: MMCard {
    override init() {
        super.init()
        
        self.key = "lr_sheji"
        self.id = 4
        self.name = "射击猎"
        
        self.attackRule = .range
        self.attackArea = .nineCube
        self.attackType = .demoralize
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        self.sp = 2
        self.hp = 100
        self.atk = 20
        self.def = 0
        self.mag = 0
        self.spd = 30
        
    }
}

class  LRShouWang: MMCard {
    override init() {
        super.init()
        
        self.key = "lr_shouwang"
        self.id = 5
        self.name = "兽王猎"
        
        self.attackRule = .range
        self.attackArea = .nineCube
        self.attackType = .demoralize
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        self.sp = 2
        self.hp = 100
        self.atk = 20
        self.def = 0
        self.mag = 0
        self.spd = 30
        
    }
}











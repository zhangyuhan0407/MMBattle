//
//  MMHouYi.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMHouYi: MMCard {
    
    
    override init() {
        super.init()
        
        self.key = "houyi"
        self.id = 2
        self.name = "后羿"
        
        self.attackRule = .range
        self.attackArea = .nineCube
        self.attackType = .physics
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.arrow.rawValue

        
        self.sp = 5
        self.hp = 100
        self.atk = 70
        self.def = 0
        self.mag = 0
        self.spd = 30
        
//        self.baoji = 30
//        self.mingzhong = 15
    }
    
    
    
    override func willHit(character: MMCharacter, damage: MMDamage) {
        if damage.skillIndex == 1 {
            damage.area = .singleTwice
            damage.userInfo.updateValue(true, forKey: "islianji")
        }
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        if damage.skillIndex == 1 {
            character.sp += 1
            damage.destination!.sp += 1
        } else {
            character.sp = 0
            for tar in allTargets {
                tar.sp += 1
            }
        }
    }
}


class MMXiongDe: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "dly_xiong"
        self.id = 9
        self.name = "熊德"
        
        self.attackRule = .melee
        self.attackArea = .single
        self.attackType = .physics
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        
        self.sp = 5
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 100
        self.spd = 30
        
        
        self.shanbi = 30
    }
    
}


class MMMaoDe: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "dly_mao"
        self.id = 9
        self.name = "猫德"
        
        self.attackRule = .reverse
        self.attackArea = .single
        self.attackType = .physics
        
        
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
        if damage.skillIndex == 2 {
            damage.destination!.addBuff(MMBuffXuanYun())
        }
    }
    
}


class MMNaiDe: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "dly_zhiliao"
        self.id = 9
        self.name = "奶德"
        
        self.attackRule = .fewerHPHelp
        self.attackArea = .all
        self.attackType = .heal
        
        
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
            attackArea = .single
        }
    }
    
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        if damage.skillIndex == 1 {
            let value = character.mag
            
            damage.destination?.addBuff(MMBuffHuiChun(value: value))
            
        } else {
            let value = character.mag.multiply(0.5)
            for damage in allTargetDamages {
                damage.destination?.addBuff(MMBuffYeXingShengZhang(value: value))
            }
        }
    }
}



class MMNiaoDe: MMCard {
    override init() {
        
        super.init()
        
        self.key = "dly_niao"
        self.id = 9
        self.name = "鸟德"
        
        self.attackRule = .range
        self.attackArea = .all
        self.attackType = .heal
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        self.sp = 5
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 100
        self.spd = 30
        
    }
    
    
    
    
}





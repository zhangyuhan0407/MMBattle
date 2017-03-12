//
//  MMFengHuang.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation

class MMFengHuang: MMCard {
    
    override init() {
        super.init()
        
        self.key = "fenghuang"
        self.id = 10
        self.name = "凤凰"
        
        self.attackRule = .fewerHP
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.magic.rawValue
        
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 40
        self.spd = 60
        
    }
    
    
}



class DZCiSha: MMCard {
    
    override init() {
        super.init()
        
        self.key = "cishazei"
        self.id = 10
        self.name = "刺杀贼"
        
        self.attackRule = .fewerHP
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.magic.rawValue
        
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 40
        self.spd = 60
        
    }
    
    
}


class DZZhanDou: MMCard {
    
    override init() {
        super.init()
        
        self.key = "zhandouzei"
        self.id = 11
        self.name = "战斗贼"
        
        self.attackRule = .melee
        self.attackArea = .single
        self.attackType = .physics
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.magic.rawValue
        
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 40
        self.spd = 60
        
    }
    
}



class DZMinRui: MMCard {
    override init() {
        super.init()
        
        self.key = "minruizei"
        self.id = 12
        self.name = "敏锐贼"
        
        self.attackRule = .next
        self.attackArea = .single
        self.attackType = .physics
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.magic.rawValue
        
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 40
        self.spd = 60
        
    }
    
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        damage.destination!.addBuff(MMBuffXuanYun())
        
        character.player?.record.putAfterFight(damage.destination!.createCustomAnimationDictionary(type: .addBuff(key: "xunyuan")))
    }
    
}















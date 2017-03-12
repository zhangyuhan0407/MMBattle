//
//  MMXingTian.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMXingTian: MMCard {
    
    override init() {
        super.init()
        
        self.key = "xingtian"
        self.id = 1
        self.name = "刑天"
        
        self.attackRule = .melee
        self.attackArea = .singleTriple
        self.attackType = .physics
        
        
        self.ball = Ball.shui.rawValue
        self.category = CharacterCategory.melee.rawValue

        
        self.sp = 3
        self.hp = 100
        self.atk = 50
        self.def = 0
        self.mag = 0
        self.spd = 10
        
        
    }
    
    
    override func willBehit(character: MMCharacter, damage: MMDamage) {
        if damage.type == .physics && damage.rule == .range {
            damage.value = damage.value.multiply(0.2)
        }
    }
    
    
}



class SMZengQiang: MMCard {
    
    override init() {
        super.init()
        
        self.key = "zengqiangsa"
        self.id = 17
        self.name = "增强萨"
        
        self.attackRule = .melee
        self.attackArea = .singleTriple
        self.attackType = .physics
        
        
        self.ball = Ball.shui.rawValue
        self.category = CharacterCategory.melee.rawValue
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 50
        self.def = 0
        self.mag = 0
        self.spd = 10
        
        
    }
    
    
    override func willHit(character: MMCharacter, damage: MMDamage) {
        if damage.skillIndex == 1 {
            if Int.random() < 30 {
                damage.area = .singleTriple
            }
        }
    }
    
}


class SMYuanSu: MMCard {
    
    override init() {
        super.init()
        
        self.key = "yuansusa"
        self.id = 18
        self.name = "元素萨"
        
        self.attackRule = .threeRandom
        self.attackArea = .single
        self.attackType = .physics
        
        
        self.ball = Ball.shui.rawValue
        self.category = CharacterCategory.melee.rawValue
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 50
        self.def = 0
        self.mag = 0
        self.spd = 10
        
        
    }
    
    
    
    //zyh!! 闪电链过载没有写
    override func willHit(character: MMCharacter, damage: MMDamage) {
        if damage.skillIndex == 1 {
            if Int.random() < 30 {
                damage.area = .singleTwice
                damage.userInfo.updateValue(true, forKey: "guozai")
            }
        } 
    }
    
    
    
    
    
}


//class SMZhiLiao: MMCard {
//    
//}

















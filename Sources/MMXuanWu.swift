//
//  MMXuanWu.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMXuanWu: MMCard {
    
    override init() {
        super.init()
        
        self.key = "xuanwu"
        self.id = 5
        self.name = "玄武"
        
        self.attackRule = .melee
        self.attackArea = .row
        self.attackType = .magic
        
        
        self.ball = Ball.shui.rawValue
        self.category = CharacterCategory.tank.rawValue
        

        self.sp = 3
        self.hp = 100
        self.atk = 10
        self.def = 40
        self.mag = 10
        self.spd = 0
        
        
    }
    
    
}



class ZSWuQi: MMCard {
    
    override init() {
        super.init()
        
        self.key = "zs_wuqi"
        self.id = 23
        self.name = "武器战"
        
        self.attackRule = .melee
        self.attackArea = .single
        self.attackType = .physics
        
        
        self.ball = Ball.shui.rawValue
        self.category = CharacterCategory.tank.rawValue
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 10
        self.def = 40
        self.mag = 10
        self.spd = 0
        
        
    }
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        if damage.skillIndex == 2 {
            damage.destination?.addBuff(MMBuffZhiSiDaJi())
            character.player?.record.putAfterFight(character.createCustomAnimationDictionary(type: .addBuff(key: "zhisidaji")))
        }
    }
    
    
}


class ZSKuangBao: MMCard {
    
    override init() {
        super.init()
        
        self.key = "zs_kuangbao"
        self.id = 24
        self.name = "狂暴战"
        
        self.attackRule = .melee
        self.attackArea = .cross
        self.attackType = .physics
        
        
        self.ball = Ball.shui.rawValue
        self.category = CharacterCategory.tank.rawValue
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 10
        self.def = 40
        self.mag = 10
        self.spd = 0
        
        
    }
    
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        if damage.skillIndex == 2 {
            for tar in allTargets {
                tar.sp += 1
                tar.addBuff(MMBuffPoJia(value: 10))
            }
            character.sp = 0
        } else {
            character.sp += 1
        }
    }
    
    
}



class ZSFangYu: MMCard {
    
    override init() {
        super.init()
        
        self.key = "zs_fangyu"
        self.id = 25
        self.name = "防战"
        
        self.attackRule = .melee
        self.attackArea = .single
        self.attackType = .physics
        
        
        self.ball = Ball.shui.rawValue
        self.category = CharacterCategory.tank.rawValue
        
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 10
        self.def = 40
        self.mag = 10
        self.spd = 0
        
        
    }
    
    
    
    
    
}


















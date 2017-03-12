//
//  MMBaiZe.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation


class MMBaiZe: MMCard {
    
    override init() {
        super.init()
        
        self.key = "baize"
        self.id = 15
        self.name = "白泽"
        
        self.attackRule = .current
        self.attackArea = .nineCube
        self.attackType = .heal
        
        
        self.ball = Ball.mu.rawValue
        self.category = CharacterCategory.magic.rawValue
        
        
        //        skill2Factor = 1.5
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 30
        self.spd = 40
        
    }
    
    
    override func willHit(character: MMCharacter, damage: MMDamage) {
        if damage.skillIndex == 1 {
            damage.rule = .fewerHP
        }
    }
    
    
}

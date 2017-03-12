//
//  MMTaoWu.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation



class MMTaoWu: MMCard {
    
    override init() {
        super.init()
        
        self.key = "taowu"
        self.id = 13
        self.name = "梼杌"
        
        self.attackRule = .melee
        self.attackArea = .cross
        self.attackType = .physics
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.melee.rawValue
        
        
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 20
        self.def = 20
        self.mag = 0
        self.spd = 20
        
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        for tar in allTargets {
            tar.sp -= 1
        }
    }
    
}

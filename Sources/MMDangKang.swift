//
//  MMDangKang.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation


class MMDangKang: MMCard {
    
    
    override init() {
        super.init()
        
        self.key = "dangkang"
        self.id = 9
        self.name = "当康"
        
        self.attackRule = .melee
        self.attackArea = .column
        self.attackType = .physics
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.melee.rawValue
        
        
        //        skill2Factor = 0.9
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 30
        self.def = 10
        self.mag = 0
        self.spd = 60
        
        
    }
    
    
    
}

//
//  MMLeiShen.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation


class MMLeiShen: MMCard {
    
    override init() {
        super.init()
        
        self.key = "leishen"
        self.id = 11
        self.name = "雷神"
        
        self.attackRule = .range
        self.attackArea = .cross
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.magic.rawValue
        
        
        //        skill1Factor = 1.2
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 70
        self.spd = 40
        
    }
    
}

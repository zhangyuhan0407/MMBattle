//
//  MMHunDun.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation



class MMHunDun: MMCard {
    
    override init() {
        super.init()
        
        self.key = "hundun"
        self.id = 12
        self.name = "混沌"
        
        self.attackRule = .range
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.huo.rawValue
        self.category = CharacterCategory.magic.rawValue
        
        
        //        skill2Factor = 1.5
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 70
        self.spd = 40
        
    }
    
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        if damage.destination!.isAlive {
            damage.destination?.addBuff(MMBuffXuanYun())
            character.player?.record.putAfterFight(damage.destination!.createCustomAnimationDictionary(type: .addBuff(key: "xunyuan")))    
        }
        
        
    }
    
    
}

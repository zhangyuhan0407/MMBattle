//
//  MMQiongQi.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation


class MMQiongQi: MMCard {
    
    override init() {
        super.init()
        
        self.key = "qiongqi"
        self.id = 16
        self.name = "穷奇"
        
        self.attackRule = .melee
        self.attackArea = .wings
        self.attackType = .physics
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.melee.rawValue
        
        
        //        skill2Factor = 1.5
        
        
        self.sp = 3
        self.hp = 100
        self.atk = 30
        self.def = 10
        self.mag = 0
        self.spd = 70
        
    }
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
        
        for tar in allTargetDamages {
            if tar.destination!.key != damage.destination!.key {
                tar.destination?.addBuff(MMBuffXuanYun())
                character.player?.record.putAfterFight(character.createCustomAnimationDictionary(type: .addBuff(key: "xuanyun")))
            }
        }
        
    }
    
    
}

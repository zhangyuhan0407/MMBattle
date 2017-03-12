//
//  MMQingNiao.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation


class MMQingNiao: MMCard {
    
    override init() {
        super.init()
        
        self.key = "qingniao"
        self.id = 14
        self.name = "青鸟"
        
        self.attackRule = .fewerSP
        self.attackArea = .single
        self.attackType = .heal
        
        
        self.ball = Ball.huo.rawValue
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
            damage.rule = .fewerSP
            attackType = .heal
            damage.value = 0
        } else {
            damage.rule = .mostSP
            attackType = .magic
        }
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        if damage.skillIndex == 1 {
            damage.destination?.sp += 5
            character.sp += 1
        } else {
            damage.destination?.sp = 0
            character.sp = 0
        }
        
    }
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
        
        let char = character.player?.fewerSPCharacters.first
        char!.sp += 5
        
        character.player?.record.putAfterFight(char!.createCustomAnimationDictionary(type: .changeSP))
    }
    
    
}

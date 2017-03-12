//
//  MMFengHou.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMFengHou: MMCard {
    
    override init() {
        super.init()
        
        self.key = "fenghou"
        self.id = 7
        self.name = "风后"
        
        self.attackRule = .melee
        self.attackArea = .single
        self.attackType = .physics
        
        
        self.ball = Ball.tu.rawValue
        self.category = CharacterCategory.help.rawValue
        
        
        
        self.sp = 1
        self.hp = 100
        self.atk = 40
        self.def = 30
        self.mag = 0
        self.spd = 40
        
    }
    
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
        
        
        let player = character.player!
        
        
        if damage.skillIndex == 2 {
            for char in player.aliveCharacters {
                if char != character {
                    char.sp += 1
                    player.battle!.record.putAfterFight(char.createCustomAnimationDictionary(type: .changeSP))
                }
                
                char.addBuff(MMBuffShiXue())
                player.battle?.record.putAfterFight(char.createCustomAnimationDictionary(type: .addBuff(key: "shixue")))
                
            }
        } else {
            let cells = AttackArea.find(position: character.position, area: .nineCube)
            let targets = player.findCharacters(inCells: cells)
            for char in targets {
                char.sp += 1
                player.battle!.record.putAfterFight(char.createCustomAnimationDictionary(type: .changeSP))
            }
        }
    }
    
}



class QSShenSheng: MMCard {
    
    override init() {
        super.init()
        
        self.key = "naiqi"
        self.id = 26
        self.name = "奶骑"
        
        self.attackRule = .fewerHPHelp
        self.attackArea = .single
        self.attackType = .heal
        
        
        self.ball = Ball.tu.rawValue
        self.category = CharacterCategory.help.rawValue
        
        
        
        self.sp = 1
        self.hp = 100
        self.atk = 40
        self.def = 30
        self.mag = 0
        self.spd = 40
        
    }
    
    
    
}


class QSChengJie: MMCard {
    
    override init() {
        super.init()
        
        self.key = "chengjieqi"
        self.id = 27
        self.name = "惩戒骑"
        
        self.attackRule = .melee
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.tu.rawValue
        self.category = CharacterCategory.help.rawValue
        
        
        
        self.sp = 1
        self.hp = 100
        self.atk = 40
        self.def = 30
        self.mag = 0
        self.spd = 40
        
    }
    
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        let player = character.player!
        
        let cells = AttackArea.find(position: character.position, area: .nineCube)
        let targets = player.findCharacters(inCells: cells)
        for char in targets {
            let offset = character.maxHP.multiply(0.2)
            char.hp += offset
            player.battle!.record.putAfterFight(char.createCustomAnimationDictionary(type: .changeHP(offset: offset)))
        }
    }
    
}



class QSFangYu: MMCard {
    override init() {
        super.init()
        
        self.key = "fangqi"
        self.id = 28
        self.name = "防骑"
        
        self.attackRule = .melee
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.tu.rawValue
        self.category = CharacterCategory.help.rawValue
        
        
        
        self.sp = 1
        self.hp = 100
        self.atk = 40
        self.def = 30
        self.mag = 0
        self.spd = 40
        
    }
}









//
//  MMSuanYu.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import OCTJSON
import OCTFoundation


class MMSuanYu: MMCard {
    
    override init() {
        super.init()
        
        self.key = "suanyu"
        self.id = 8
        self.name = "酸与"
        
        self.attackRule = .mostSP
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        
        self.sp = 2
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 20
        self.spd = 70
        
//        self.mingzhong = 1000
        
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        
        if damage.skillIndex == 2 {
            character.sp = 0
        }

        if damage.destination!.sp > 0 {
            character.sp += 1
            damage.destination!.sp -= 1
        }
        
    }
    
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
        
        
        if allTargetDamages.count == 1 {
            allTargetDamages[0].destination!.addBuff(MMBuffXuanYun())
            allTargetDamages[0].userInfo.updateValue("xuanyun", forKey: "addbuff")
        } else {
            Logger.error("target count: \(allTargetDamages.count)")
        }
    }

    
}


class FSAoShu: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "fs_aoshu"
        self.id = 1
        self.name = "奥法"
        
        self.attackRule = .range
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        
        
        self.sp = 2
        self.hp = 300
        self.atk = 0
        self.def = 0
        self.mag = 130
        self.spd = 30
        
    }
    
    
    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        
        if damage.skillIndex == 2 {
            character.sp = 0
        }
        
        if damage.destination!.sp > 0 {
            character.sp += 1
            damage.destination!.sp -= 1
        }
        
    }
    
    
    override func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        super.didHit(character: character, mainTargetDamage: damage, allTargetDamages: allTargetDamages)
        
        
        damage.destination!.addBuff(MMBuffXuanYun())
        damage.userInfo.updateValue("xuanyun", forKey: "addbuff")
        
    }

}


class FSBingShuang: MMCard {
    override init() {
        
        super.init()
        
        self.key = "fs_bingshuang"
        self.id = 2
        self.name = "冰法"
        
        self.attackRule = .range
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        skill2Factor = 1.5
        
        self.sp = 2
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 90
        self.spd = 30
        
        self.baoji = 30
        
    }
}



class FSHuoYan: MMCard {
    
    override init() {
        
        super.init()
        
        self.key = "fs_huoyan"
        self.id = 3
        self.name = "火法"
        
        self.attackRule = .range
        self.attackArea = .single
        self.attackType = .magic
        
        
        self.ball = Ball.jin.rawValue
        self.category = CharacterCategory.disabler.rawValue
        
        skill2Factor = 1.5
        
        self.sp = 2
        self.hp = 100
        self.atk = 0
        self.def = 0
        self.mag = 90
        self.spd = 30
        
        self.baoji = 30
        
    }
    
    
    
}













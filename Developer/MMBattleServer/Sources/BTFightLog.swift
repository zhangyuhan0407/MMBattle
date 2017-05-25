//
//  MMBaiZe.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation
import OCTJSON


struct BTFightLog {
    
    var unit: MMUnit
    
    var skill: BTSkill!
    
    var mainDamage: MMDamage?
    
    var sideDamages: [MMDamage] = []
    
    var beforeFight: [[String: Any]] = []
    
    var afterFight: [[String: Any]] = []
    
    let originalState: JSON
    
    var finalState: JSON = nil
    
    init(unit: MMUnit) {
        self.unit = unit
        self.originalState = JSON(unit.state)
        
    }
    
    
    var json: JSON {
        
        var dict: [String: JSON] = [kUnit: originalState,
                                    kSkill: skill.json]
        
        
        if let mainDamage = self.mainDamage {
            dict.updateValue(mainDamage.json, forKey: kMainDamage)
        }
        
        
        var sideJSONs = [JSON]()
        for damage in sideDamages {
            sideJSONs.append(damage.json)
        }
        dict.updateValue(JSON(sideJSONs), forKey: kSideDamage)
        
        
        var beforeJSONs = [JSON]()
        for b in self.beforeFight {
            beforeJSONs.append(JSON(b))
        }
        dict.updateValue(JSON(beforeJSONs), forKey: "before")
        
        var afterJSONs = [JSON]()
        for a in self.afterFight {
            afterJSONs.append(JSON(a))
        }
        dict.updateValue(JSON(afterJSONs), forKey: "after")
        
        
        dict.updateValue(finalState, forKey: "finalstate")
        
        
        let json = JSON(dict)
        
        return json
    }
    
    
    mutating func pin() {
        self.finalState = JSON(unit.state)
    }
    
}


//
//
//class MMBaiZe: MMCard {
//    
//    override init() {
//        super.init()
//        
//        self.key = "baize"
//        self.id = 15
//        self.name = "白泽"
//        
//        self.attackRule = .current
//        self.attackArea = .nineCube
//        self.attackType = .heal
//        
//        
//        self.ball = Ball.mu.rawValue
//        self.category = CharacterCategory.magic.rawValue
//        
//        
//        //        skill2Factor = 1.5
//        
//        
//        self.sp = 3
//        self.hp = 100
//        self.atk = 0
//        self.def = 0
//        self.mag = 30
//        self.spd = 40
//        
//    }
//    
//    
//    override func willHit(character: MMCharacter, damage: MMDamage) {
//        if damage.skillIndex == 1 {
//            damage.rule = .fewerHP
//        }
//    }
//    
//    
//}

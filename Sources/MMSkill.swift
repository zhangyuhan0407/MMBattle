//
//  MMTaoWu.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation
import OCTJSON


final class BTSkill: JSONDeserializable {
    
    let sour: MMUnit
    
    var index = 0
    var area: MMAttackArea = .main
    var type: MMAttackType = .none
    
    var unit: MMUnit?
    var mainDamage: MMDamage?
    var sideDamages: [MMDamage]?
    
    lazy var userinfo: [String: Any] = [:]
    
    init(unit: MMUnit) {
        self.sour = unit
    }
    
    
    static func deserialize(fromJSON json: JSON) -> BTSkill {
        let unit = MMUnit.deserialize(fromJSON: json[kUnit])
        return BTSkill(unit: unit)
    }
    
    
    var dict: [String: Any] {
        
        return  [kSourcePlayerKey: sour.player.key,
                kSourceCardKey: sour.card.key,
                kSkillIndex: index,
                kAttackArea: area.rawValue,
                kAttackType: type.rawValue]
        
        
    }
    
}








//
//
//
//class MMTaoWu: MMCard {
//    
//    override init() {
//        super.init()
//        
//        self.key = "taowu"
//        self.id = 13
//        self.name = "梼杌"
//        
//        self.attackRule = .melee
//        self.attackArea = .cross
//        self.attackType = .physics
//        
//        
//        self.ball = Ball.jin.rawValue
//        self.category = CharacterCategory.melee.rawValue
//        
//        
//        
//        
//        self.sp = 3
//        self.hp = 100
//        self.atk = 20
//        self.def = 20
//        self.mag = 0
//        self.spd = 20
//        
//    }
//    
//    
//    override func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
//        for tar in allTargets {
//            tar.sp -= 1
//        }
//    }
//    
//}

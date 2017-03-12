//
//  MMSkill.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/21/16.
//
//

import Foundation
import OCTJSON
import OCTFoundation


class MMDamage {
    
    var source: MMCharacter
    
    var destination: MMCharacter?
    
    var sideTargets: [MMCharacter]?
    
    var value: Int = 0
    
    var rule: AttackRule = .melee
    var area: AttackArea = .single
    var type: AttackType = .physics
    
    
    var skillIndex = 1
    var ball = 0
    
    var isBaoji: Bool = false
    var isShanbi: Bool = false
    var isGedang: Bool = false
    var isMianyi: Bool = false
    
    
    lazy var userInfo = [String: Any]()
    
    
    init(source: MMCharacter) {
        self.source = source
    }
    
    var json: JSON {
        let dict: [String : Any] = ["source": source.card.key,
                                    "value": value,
                                    "rule": rule,
                                    "area": area,
                                    "type": type,
                                    "skill": skillIndex,
                                    "isbaoji": isBaoji,
                                    "isshanbi": isShanbi,
                                    "isgedang": isGedang,
                                    "ismianyi": isMianyi]
        
        
        return JSON(dict + userInfo)
    }
    
    
    func copy() -> MMDamage {
        let damage = MMDamage(source: self.source)
        damage.destination = self.destination
        damage.value = self.value
        damage.type = self.type
        damage.rule = self.rule
        damage.area = area
        damage.skillIndex = skillIndex
        damage.isBaoji = isBaoji
        damage.isShanbi = isShanbi
        damage.isGedang = isGedang
        damage.isMianyi = isMianyi
//        damage.userInfo = userInfo
        
        return damage
    }
    
    
}















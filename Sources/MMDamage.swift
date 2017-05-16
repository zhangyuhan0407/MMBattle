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


final class MMDamage: JSONDeserializable {
    
    var source: MMUnit
    
    var destination: MMUnit!
    
    var value: Int = 0
    
    var type: MMAttackType = .physics
    
    var isBaoji: Bool = false
    var isShanbi: Bool = false
    var isGedang: Bool = false
    var isMianyi: Bool = false
    
    
    var userInfo = [String: Any]()
    
    
    init(source: MMUnit) {
        self.source = source
    }
    
    
    static func deserialize(fromJSON json: JSON) -> MMDamage {
        
        let unit = MMUnit.deserialize(fromJSON: json[kSourceCardKey])
//        let unit = 
        let ret = MMDamage(source: unit)
        ret.destination = MMUnit.deserialize(fromJSON: json[kDestinationCardKey])
        ret.value = json[kValue].intValue
        ret.type = MMAttackType(rawValue: json[kType].stringValue)!
        ret.isBaoji = json[kIsBaoji].boolValue
        ret.isMianyi = json[kIsMianyi].boolValue
        ret.isGedang = json[kIsGedang].boolValue
        ret.isShanbi = json[kIsShanbi].boolValue
//        ret.userInfo = json["userinfo"].stringDictionary
        
        return ret
    }
    
    
    var dict: [String: Any] {
        let dict: [String : Any] = [kSource: source.state,
                                    kDestination: destination.state,
                                    kValue: value,
                                    kType: type.rawValue,
                                    kIsBaoji: isBaoji,
                                    kIsShanbi: isShanbi,
                                    kIsGedang: isGedang,
                                    kIsMianyi: isMianyi,
                                    "userinfo": userInfo]
        
        return dict
    }

    
    func addBuff(buff: String) {
        self.userInfo.updateValue(buff, forKey: kAddBuff)
    }
    
//    
//    func copy() -> MMDamage {
//        let damage = MMDamage(source: self.source)
//        damage.destination = self.destination
//        damage.value = self.value
//        damage.type = self.type
////        damage.rule = self.rule
////        damage.area = area
////        damage.skillIndex = skillIndex
//        damage.isBaoji = isBaoji
//        damage.isShanbi = isShanbi
//        damage.isGedang = isGedang
//        damage.isMianyi = isMianyi
////        damage.userInfo = userInfo
//        
//        return damage
//    }
    
    
}















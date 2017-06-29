//
//  MMCharacter.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import OCTJSON


//typealias MMUnit = MMCharacter


final class MMUnit: JSONDeserializable {
    
    weak var _player: MMBattlePlayer?
    
    var player: MMBattlePlayer {
        return _player!
    }
    
    var enemy: MMBattlePlayer {
        return player.enemy
    }
    
    var record: MMBattleRecord {
        return self.player.record
    }
    
    var card: MMCard!

    var attackType: MMAttackType = .none
    var key: String = ""
    var position: Int = 0
    var cls: String = ""
    
    var buffs: [MMBuff] = []
    
    var maxHP: Int = 100
    var maxSP: Int = 3
    
    
    var observer = [MMUnitObservable]()
    
    
//    var key: String {
//        return self.card.key
//    }
    
    
    private var _hp: Int = 0
    var hp: Int {
        set {
            var temp = newValue
            
            if self.hasBuff("zhisidaji") {
                if newValue > self._hp {
                    temp = _hp
                }
            }
            
            
            for ob in self.observer {
                ob.onHPChanged(character: self, newValue: &temp, oldValue: _hp)
            }
            
            
            if temp < 0 {
                temp = 0
            } else if temp > maxHP {
                temp = maxHP
            }
            
            self._hp = temp
            
        }
        get {
            return self._hp
        }
    }
    
    private var _sp: Int = 0
    var sp: Int {
        set {
            var temp = newValue
            
            if self.hasBuff("shixue") {
                if newValue < self._sp {
                    temp = _sp
                }
            }
            
//            if self.hasBuff("chenmo") {
//                if newValue > self._sp {
//                    temp = _sp
//                }
//            }
            
            if temp < 0 {
                temp = 0
            } else if temp > maxSP {
                temp = maxSP
            }
            self._sp = temp
        }
        get {
            return self._sp
        }
    }
    
    
    
    var atk: Int = 0
    var def: Int = 0
    var mag: Int = 0
    var spd: Int = 0
    
    var baoji: Int = 0
    var shanbi: Int = 0
    var mingzhong: Int = 0
    var gedang: Int = 0
    
    var zaisheng = 0
    var xixue = 0
    var fantanwuli = 0
    var fantanfashu = 0
    
    
    var skill1Factor: Int = 100
    var skill2Factor: Int = 100
    
    var userinfo = [String: Any]()
    
    
    
    var isAlive: Bool {
        return self.hp > 0
    }
    
    var isAttackedInCurrentRound: Bool = false
    
    
    
    init() {}
    
    
    
    static func deserialize(fromJSON json: JSON) -> MMUnit {
        
        let char = MMUnit()
        char.card = MMCardFactory.sharedInstance.findCard(forCls: json["cls"].string!)
        
        
        
        char.key = json[kKey].string!
        char.cls = json["cls"].string!
        char.position = json[kPosition].int ?? 0
        char.attackType = MMAttackType(rawValue: json["attacktype"].string!)!
        
        
        char.skill1Factor = json["skill1factor"].int!
        char.skill2Factor = json["skill2factor"].int!
        
        char.maxHP = json[kMaxHP].int!
        char.maxSP = json[kMaxSP].int!
        
        char.hp = json[kHP].int ?? char.maxHP
        char.sp = json[kSP].int ?? 0
        
        
        char.atk = json[kATK].int!
        char.mag = json[kMAG].int ?? 0
        char.def = json[kDEF].int ?? 0
        char.spd = json[kSPD].int ?? 0
        
        char.baoji = json[kBaoJi].int ?? 0
        char.mingzhong = json[kMingZhong].int ?? 0
        char.shanbi = json[kShanBi].int ?? 0
        char.gedang = json[kGeDang].int ?? 0
        
        char.xixue = json[kXiXue].int ?? 0
        char.zaisheng = json[kZaiSheng].int ?? 0
        char.fantanwuli = json[kFanTanWuLi].int ?? 0
        char.fantanfashu = json[kFanTanFaShu].int ?? 0
        
        
        if let array = json[kBuffs].array {
            for buff in array {
                char.addBuff(MMBuff.deserialize(fromJSON: buff))
            }
        }
        
        return char
    }
    
    
    
    
    
    var state: [String: Any] {
        var dict: [String: Any] = [kPlayerKey: player.key,
                                   kCardKey: key,
                                   kPosition: position,
                                   kMaxHP: maxHP,
                                   kMaxSP: maxSP,
                                   kHP: hp,
                                   kSP: sp]
        
        if let dun = self.findBuff("dun") as? MMBuffDun {
            dict.updateValue(dun.value, forKey: "dunvalue")
        }
        
        
        return dict
    }
    
    var dict: [String : Any] {
        return state
    }
    
    
}


func ==(char1: MMUnit, char2: MMUnit) -> Bool {
    return char1.card.key == char2.card.key
}

func !=(char1: MMUnit, char2: MMUnit) -> Bool {
    return char1.card.key != char2.card.key
}




//class 









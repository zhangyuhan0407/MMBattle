//
//  MMBuff.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/21/16.
//
//

import Foundation
import OCTJSON


enum BuffType: String {
    case chenmo
    
}


class MMBuff: MMUnitFlow {
    
    var key: String = "DEFAULT"
    var id: Int = 0
    var name: String = "默认BUFF"
    
    var userinfo: [String: Any]?
    
    weak var character: MMUnit?
    
    var defaultRound = 1 {
        didSet {
            if self.remainRound > defaultRound {
                remainRound = defaultRound
            }
        }
    }
    
    
    var remainRound: Int = 1 {
        didSet {
            if remainRound <= 0 {
                self.removeFromCharacter()
            }
        }
    }

    
    func reset() {
        self.remainRound = defaultRound
    }
    
    
    func removeFromCharacter() {
        character!.record.putBeforeFight(character!.createCustomAnimationDictionary(type: .removeBuff(key: self.key)))
        self.character!.removeBuff(self)
    }
    
    
    static func deserialize(fromJSON json: JSON) -> MMBuff {
        return MMBuff()
    }
    
    
    
    func willHit(character: MMUnit) {
        self.remainRound -= 1
    }
    
    
    func willBehit(character: MMUnit, skill: BTSkill) { }
    
    
    func didBehit(character: MMUnit, skill: BTSkill, damage: MMDamage) { }
    
    
    func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        
    }
    
    
    
    //Templates
    
    
    func willAddToCharacter() {
        
    }
    
    func didAddToCharacter() {
        
    }
    
    func willRemoveFromCharacter() {
        
    }
    
    func didRemoveFromCharacter() {
        
    }
    
    
}


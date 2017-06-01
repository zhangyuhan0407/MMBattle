//
//  MMCharacter+Utility.swift
//  AAA
//
//  Created by yuhan zhang on 10/29/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


enum CustomAnimation {
    case changeHP(offset: Int)
    case changeSP
    case addBuff(key: String)
    case removeBuff(key: String)
}




extension MMUnit {
    
    
    func createCustomAnimationDictionary(type: CustomAnimation) -> [String: Any] {
        
        switch type {
        case .changeHP(let offset):
            return ["playerkey": self.player.key,
                    "cardkey": self.card.key,
                    "cellid": position,
                    "reason": "changehp",
                    "hp": self.hp,
                    "maxhp": self.maxHP,
                    "offsethp": offset]
        case .changeSP:
            return ["playerkey": self.player.key,
                    "cardkey": self.card.key,
                    "cellid": position,
                    "reason": "changesp",
                    "sp": self.sp,
                    "maxsp": self.maxSP]
        case .addBuff(let key):
            return ["playerkey": self.player.key,
                    "cardkey": self.card.key,
                    "cellid": position,
                    "reason": "addbuff",
                    "buffname": key]
        case .removeBuff(let key):
            return ["playerkey": self.player.key,
                    "cardkey": self.card.key,
                    "cellid": position,
                    "reason": "removebuff",
                    "buffname": key]
        }
         
    }
    
    
    func handleZaiSheng() {
        if self.zaisheng > 0 {
            let offset = self.maxHP.multiply(zaisheng.toPercentage())
            self.hp += offset
            self.player.record.putBeforeFight(self.createCustomAnimationDictionary(type: .changeHP(offset: offset)))
        }
    }
    
    
    func handleXixue(damage: MMDamage) {
        if self.xixue > 0 {
            let offset = damage.value.multiply(xixue.toPercentage())
            self.hp += offset
            self.player.record.putAfterFight(self.createCustomAnimationDictionary(type: .changeHP(offset: offset)))
        }
    }
    
    
    func handleFanTanWuLi(damage: MMDamage) {
        if self.fantanwuli > 0 && damage.type == .physics {
            let offset = damage.value.multiply(fantanwuli.toPercentage())
            damage.source.hp -= offset
            _ = damage.userInfo.updateValue(offset, forKey: "fantanwuli")
        }
    }
    
    
    func handleFanTanFaShu(damage: MMDamage) {
        if fantanfashu > 0 && damage.type != .physics {
            let offset = damage.value.multiply(fantanfashu.toPercentage())
            damage.source.hp -= offset
            _ = damage.userInfo.updateValue(offset, forKey: "fantanfashu")
        }
    }
    

    
    
}










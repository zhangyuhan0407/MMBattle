//
//  MMBuffZhanYiGaoAng.swift
//  AAA
//
//  Created by yuhan zhang on 10/28/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMBuffBingHuan: MMBuff {
    
    override init() {
        super.init()
        self.key = "binghuan"
        self.id = 1
        self.name = "冰环"
        self.defaultRound = 2
        self.remainRound = 2
    }
    
    func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage) {
        self.remainRound -= 1
    }
    
}


class MMBuffChenMo: MMBuff {
    override init() {
        super.init()
        self.key = "chenmo"
        self.id = 2
        self.name = "沉默"
        self.defaultRound = 1
        self.remainRound = 1
    }
    
    func didHit(character: MMCharacter, ofPlayer player: MMBattlePlayer, mainTargetDamage damage: MMDamage) {
        self.remainRound -= 1
    }
}


class MMBuffDun: MMBuff, MMCharacterObservable {
    
    var value: Int {
        didSet {
            if value <= 0 {
                self.removeFromCharacter()
            }
        }
    }
    
    init(value: Int) {
        self.value = value
        super.init()
        
        self.key = "dun"
        self.id = 3
        self.name = "盾"
        self.defaultRound = 30
        self.remainRound = 30
        
        character?.observer.append(self)
    }
    
    override func reset() {
        let maxValue = userinfo?["maxvalue"] as? Int ?? 0
        self.value = maxValue
    }
    
    
    func onHPChanged(character: MMCharacter, newValue: inout Int, oldValue: Int) {
        if newValue >= oldValue {
            return
        }
        
        var offset = newValue - oldValue
        if self.value + offset >= 0 {
            self.value = self.value + offset
            newValue = oldValue
        } else {
            offset = self.value + offset
            newValue = oldValue + offset
        }
        
    }
    
    
}


class MMBuffXianJi: MMBuff {
    
    var value: Int
    init(value: Int) {
        self.value = value
        super.init()
        self.key = "xianji"
        self.id = 4
        self.name = "献祭"
        self.defaultRound = 3
        self.remainRound = 3
    }
    
    func willHit(character: MMCharacter, damage: MMDamage) {
        character.hp -= value
        
        character.player?.record.putBeforeFight(character.createCustomAnimationDictionary(type: .changeHP(offset: value)))
        
    }
}


class MMBuffKuChu: MMBuff {
    
    var value: Int
    init(value: Int) {
        self.value = value
        super.init()
        self.key = "kuchu"
        self.id = 5
        self.name = "苦楚"
        self.defaultRound = 3
        self.remainRound = 3
    }
    
    func willHit(character: MMCharacter, damage: MMDamage) {
        let realValue: Int
        if character.hasBuff("tongkuwuchang") {
            realValue = value * 2
        } else {
            realValue = value
        }
        
        character.hp -= realValue
        
        character.player?.record.putBeforeFight(character.createCustomAnimationDictionary(type: .changeHP(offset: realValue)))
        
    }
    
}


class MMBuffTongKuWuChang: MMBuff {
    override init() {
        super.init()
        self.key = "tongkuwuchang"
        self.id = 6
        self.name = "痛苦无常"
        self.defaultRound = 2
        self.remainRound = 2
    }
    
    func didHit(character: MMCharacter, ofPlayer player: MMBattlePlayer, mainTargetDamage damage: MMDamage) {
        self.remainRound -= 1
    }
}


class MMBuffXuanYun: MMBuff {
    
    override init() {
        super.init()
        self.key = "xuanyun"
        self.id = 7
        self.name = "眩晕"
        self.defaultRound = 1
        self.remainRound = 1
    }
    
    func didHit(character: MMCharacter, ofPlayer player: MMBattlePlayer, mainTargetDamage damage: MMDamage) {
        self.remainRound -= 1
    }
    
}



class MMBuffHuiChun: MMBuff {
    
    var value: Int
    
    init(value: Int) {
        self.value = value
        super.init()
        self.key = "huichun"
        self.id = 8
        self.name = "回春"
        self.defaultRound = 3
        self.remainRound = 3
    }
    
    func didHit(character: MMCharacter, ofPlayer player: MMBattlePlayer, mainTargetDamage damage: MMDamage) {
        
        character.hp += value

        character.player?.record.putAfterFight(character.createCustomAnimationDictionary(type: .changeHP(offset: value)))
        
        self.remainRound -= 1
    }
    
}



class MMBuffYeXingShengZhang: MMBuff {
    
    var value: Int
    
    init(value: Int) {
        self.value = value
        super.init()
        self.key = "yexingshengzhang"
        self.id = 9
        self.name = "野性生长"
        self.defaultRound = 3
        self.remainRound = 3
    }
    
    func didHit(character: MMCharacter, ofPlayer player: MMBattlePlayer, mainTargetDamage damage: MMDamage) {
        
        character.hp += value
        
        character.player?.record.putAfterFight(character.createCustomAnimationDictionary(type: .changeHP(offset: value)))
        
        self.remainRound -= 1
    }
    
}


class MMBuffZhiSiDaJi: MMBuff {
    
    override init() {
        super.init()
        self.key = "zhisidaji"
        self.id = 10
        self.name = "致死打击"
        self.defaultRound = 2
        self.remainRound = 2
    }
    
    func didHit(character: MMCharacter, ofPlayer player: MMBattlePlayer, mainTargetDamage damage: MMDamage) {
        self.remainRound -= 1
    }
    
}


class MMBuffPoJia: MMBuff {
    
    var value: Int
    
    init(value: Int) {
        self.value = value
        super.init()
        self.key = "pojia"
        self.id = 11
        self.name = "破甲"
        self.defaultRound = 3
        self.remainRound = 3
    }
    
    override func willAddToCharacter() {
        character?.def -= value
    }
    
    override func willRemoveFromCharacter() {
        character?.def += value
    }
    
    func didHit(character: MMCharacter, ofPlayer player: MMBattlePlayer, mainTargetDamage damage: MMDamage) {
        self.remainRound -= 1
    }
    
}


class MMBuffShiXue: MMBuff {
    
    override init() {
        super.init()
        self.key = "shixue"
        self.id = 10
        self.name = "嗜血"
        self.defaultRound = 1
        self.remainRound = 1
    }
    
    
    var atkOffset = 0
    
    
    override func didAddToCharacter() {
        atkOffset = self.character?.atk.multiply(0.2) ?? 0
        self.character?.atk += atkOffset
    }
    
    override func willRemoveFromCharacter() {
        character?.atk -= atkOffset
    }
    
    
    func didHit(character: MMCharacter, ofPlayer player: MMBattlePlayer, mainTargetDamage damage: MMDamage) {
        self.remainRound -= 1
    }
    
}





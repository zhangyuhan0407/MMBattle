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
    
}


class MMBuffChenMo: MMBuff {
    override init() {
        super.init()
        self.key = "chenmo"
        self.id = 2
        self.name = "沉默"
        self.defaultRound = 2
        self.remainRound = 2
    }
    
}


class MMBuffDun: MMBuff, MMUnitObservable {
    
    var observerKey = "dun"
    
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
        
        userinfo = ["maxvalue": value]

    }
    
    override func reset() {
        let maxValue = userinfo?["maxvalue"] as? Int ?? 0
        self.value = maxValue
    }
    
    
    override func willAddToCharacter() {
        character!.observer.append(self)
    }
    
    override func didRemoveFromCharacter() {
        character!.observer = character!.observer.filter {
            $0.observerKey != self.observerKey
        }
        
    }
    
    
    func onHPChanged(character: MMUnit, newValue: inout Int, oldValue: Int) {
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
            self.removeFromCharacter()
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
    
    
    
    
    func willHit(character: MMUnit, damage: MMDamage) {
        character.hp -= value
        
        character.player.record.putBeforeFight(character.createCustomAnimationDictionary(type: .changeHP(offset: value)))
    }
    
    
}



class MMBuffFuShiShu: MMBuff {
    var value: Int
    init(value: Int) {
        self.value = value
        super.init()
        self.key = "fushishu"
        self.id = 5
        self.name = "腐蚀术"
        self.defaultRound = 99
        self.remainRound = 99
    }
    
    override func willHit(character: MMUnit) {
        character.hp -= value
        character.record.putBeforeFight(character.createCustomAnimationDictionary(type: .changeHP(offset: -value)))
    }
    
    func validate() {
        character!.hp -= self.value
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
    
    func didHit(character: MMUnit, ofPlayer player: MMBattlePlayer, mainTargetDamage damage: MMDamage) {
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
    
    
    func willHit(character: MMUnit, skill: BTSkill) {
        
        character.hp += value
        
        character.player.record.putBeforeFight(character.createCustomAnimationDictionary(type: .changeHP(offset: value)))
        
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
    
    
    override func didHit(character: MMUnit, skill: BTSkill, mainDamage: MMDamage?, sideDamages: [MMDamage]) {
        character.hp += value
        
        character.player.record.putAfterFight(character.createCustomAnimationDictionary(type: .changeHP(offset: value)))
        
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
    
}


class MMBuffEmoXingTai: MMBuff {
    override init() {
        super.init()
        self.key = "emoxingtai"
        self.id = 11
        self.name = "恶魔形态"
        self.defaultRound = 3
        self.remainRound = 3
    }
}



class MMBuffDunQiang: MMBuff {
    override init() {
        super.init()
        self.key = "dunqiang"
        self.id = 12
        self.name = "盾墙"
        self.defaultRound = 1
        self.remainRound = 1
    }
}



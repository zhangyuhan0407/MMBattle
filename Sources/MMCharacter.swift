//
//  MMCharacter.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


class MMCharacter {
    
    weak var player: MMBattlePlayer?
    
    var card: MMCard
    var fabao: MMFabaoModel
    var position: Int
    
    var buffs: [MMBuff] = []
    
    var maxHP: Int = 100
    var maxSP: Int = 3
    
    
    var observer = [MMCharacterObservable]()
    
    
    
    var key: String {
        return self.card.key
    }
    
    
    private var _hp: Int = 0
    var hp: Int {
        set {
            var temp = newValue
            
            if self.hasBuff("zhisidaji") {
                if newValue > self._hp {
                    temp = _hp
                }
            }
            
            if temp < 0 {
                temp = 0
            } else if temp > maxHP {
                temp = maxHP
            }
            
            for ob in self.observer {
                ob.onHPChanged(character: self, newValue: &temp, oldValue: _hp)
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
            
            if self.hasBuff("chenmo") {
                if newValue > self._sp {
                    temp = _sp
                }
            }
            
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
    
    
    
    var isAlive: Bool {
        return self.hp > 0
    }
    
    var isAttackedInCurrentRound: Bool = false
    
    
    
    
    
    init(card: MMCard, fabao: MMFabaoModel, position: Int) {
        
        self.card = card
        self.fabao = fabao
        self.position = position
        
        self.maxHP = card.hp + fabao.hp
        self.maxSP = card.sp
        
        self.hp = maxHP
        self.sp = 0
        
        self.atk = card.atk + fabao.atk
        self.def = card.def + fabao.def
        self.mag = card.mag + fabao.mag
        self.spd = card.spd + fabao.spd
        
        self.baoji = card.baoji + fabao.baoji
        self.shanbi = card.shanbi + fabao.shanbi
        self.mingzhong = card.mingzhong + fabao.mingzhong
        self.gedang = card.gedang + fabao.gedang
        
        
        self.zaisheng = card.zaisheng + fabao.zaisheng
        self.xixue = card.xixue + fabao.xixue
        self.fantanwuli = card.fantanwuli + fabao.fantanwuli
        self.fantanfashu = card.fantanfashu + fabao.fantanfashu
        
    }
    
    
    
}


func ==(char1: MMCharacter, char2: MMCharacter) -> Bool {
    return char1.card.key == char2.card.key
}

func !=(char1: MMCharacter, char2: MMCharacter) -> Bool {
    return char1.card.key != char2.card.key
}










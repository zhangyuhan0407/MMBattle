//
//  MMUtility.swift
//  AAA
//
//  Created by yuhan zhang on 10/26/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import OCTJSON
import OCTFoundation


//MARK:- Utility



func makeAttackValue(forCharacter char: MMUnit) -> Int {
    return char.atk / 3
}


func makeMagicValue(forCharacter char: MMUnit) -> Int {
    return char.mag / 3
}


func makeRealValue(forCharacter char: MMUnit) -> Int {
    return char.atk / 3
}


func makeHealValue(forCharacter char: MMUnit) -> Int {
    return -char.mag
}




func makeMingZhong(char1: MMUnit, char2: MMUnit) -> Bool {
    
    if char1.mingzhong > char2.shanbi {
        return true
    } else {
        let offset = 100 - (char2.shanbi - char1.mingzhong)
        let random = Int.random()
        if random < offset {
            return true
        }
    }
    
    return false
    
}

func makeBaoJi(char1: MMUnit, char2: MMUnit) -> Bool {
    let random = Int.random()
    if char1.baoji > random {
        return true
    }
    
    return false
}

func makeGeDang(char1: MMUnit, char2: MMUnit) -> Bool {
    let random = Int.random()
    if char2.gedang > random {
        return true
    }
    
    return false
}









func makeCalculatedValue(damage: MMDamage, char1: MMUnit, char2: MMUnit) -> MMDamage {
    
//    if damage.type == .physics {
//        damage.value -= char2.def
//        damage.value = max(damage.value, 0)
//    }
//    
//    return damage
    
    
    
    //固定伤害
//    if damage.type == .real {
//        return damage
//    }
    
    
    
    //数值波动
//    let random = Int.random()/5
//    damage.value = damage.value.multiply(Float(110 - random)/100)
    
    
    
    //治疗伤害
    if damage.value < 0 {
        if makeBaoJi(char1: char1, char2: char2) {
            damage.isBaoji = true
            damage.value = damage.value.multiply(1.5)
        }
        
        return damage
    }
    
   
    //物理伤害
    if damage.type == .physics {
        damage.value -= char2.def
        
        //暴击、命中、闪避、格挡
        if makeMingZhong(char1: char1, char2: char2) {
            if makeBaoJi(char1: char1, char2: char2) {
                damage.isBaoji = true
                damage.value = damage.value.multiply(2)
            }
            
            if makeGeDang(char1: char1, char2: char2) {
                damage.isGedang = true
                damage.value = damage.value.multiply(0.6)
            }
            
        } else {
            damage.isShanbi = true
            damage.value = 0
        }
        
        
        //处理异常
        if damage.value < 0 {
            damage.value = 0
        }

        return damage
    }
    
    
    
    //法术伤害
    if damage.type != .physics {
        if makeMingZhong(char1: char1, char2: char2) {
            if makeBaoJi(char1: char1, char2: char2) {
                damage.isBaoji = true
                damage.value = damage.value.multiply(1.5)
            }
        }
        else {
            damage.isShanbi = true
            damage.value = 0
        }
        
        //处理异常
        if damage.value < 0 {
            damage.value = 0
        }
        
        return damage
    }
    
    
    
    return damage
    
}



















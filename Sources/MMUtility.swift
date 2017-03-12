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



func makeAttackValue(forCharacter char: MMCharacter) -> Int {
    return char.atk
}


func makeMagicValue(forCharacter char: MMCharacter) -> Int {
    return char.mag
}


func makeRealValue(forCharacter char: MMCharacter) -> Int {
    return char.atk
}


func makeHealValue(forCharacter char: MMCharacter) -> Int {
    return -char.mag
}




func makeMingZhong(char1: MMCharacter, char2: MMCharacter) -> Bool {
    
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

func makeBaoJi(char1: MMCharacter, char2: MMCharacter) -> Bool {
    let random = Int.random()
    if char1.baoji > random {
        return true
    }
    
    return false
}

func makeGeDang(char1: MMCharacter, char2: MMCharacter) -> Bool {
    let random = Int.random()
    if char1.gedang > random {
        return true
    }
    
    return false
}









func makeCalculatedValue(damage: MMDamage, char1: MMCharacter, char2: MMCharacter) -> MMDamage {
    
//    if damage.type == .physics {
//        damage.value -= char2.def
//        damage.value = max(damage.value, 0)
//    }
//    
//    return damage
    
    
    
    //固定伤害
    if damage.type == .real {
        return damage
    }
    
    
    
    //数值波动
//    let random = Int.random()/5
//    damage.value = damage.value.multiply(Float(110 - random)/100)
    
    
    
    //治疗伤害
    if damage.type == .heal {
        if makeBaoJi(char1: char1, char2: char2) {
            damage.value = damage.value.multiply(1.4)
        }
        
        damage.value -= char2.hp.multiply(0.05)
        
        return damage
    }
    
   
    //物理伤害
    if damage.type == .physics {
        damage.value -= char2.def
        
        //暴击、命中、闪避、格挡
        if makeMingZhong(char1: char1, char2: char2) {
            if makeBaoJi(char1: char1, char2: char2) {
                damage.isBaoji = true
                damage.value = damage.value.multiply(1.5)
            }
            
            if makeGeDang(char1: char1, char2: char2) {
                damage.isGedang = true
                damage.value = damage.value.multiply(0.55)
            }
            
        } else {
            damage.isShanbi = true
            damage.value = 0
        }
        
        
        //处理异常
        if damage.value < 0 {
            damage.value = 0
        }
        
        let factor: Float
        if damage.skillIndex == 1 {
            factor = char1.card.skill1Factor
        } else {
            factor = char1.card.skill2Factor
        }
        
        damage.value = damage.value.multiply(factor)
        
        return damage
    }
    
    
    
    //法术伤害
    if damage.type == .magic {
//        damage.value -= char2.mag.multiply(0.5)
        
        if makeBaoJi(char1: char1, char2: char2) {
            damage.isBaoji = true
            damage.value = damage.value.multiply(1.75)
        }
        
        //处理异常
        if damage.value < 0 {
            damage.value = 0
        }
        
        let factor: Float
        if damage.skillIndex == 1 {
            factor = char1.card.skill1Factor
        } else {
            factor = char1.card.skill2Factor
        }
        
        damage.value = damage.value.multiply(factor)
        
        return damage
    }
    
    
    
    return damage
    
}



















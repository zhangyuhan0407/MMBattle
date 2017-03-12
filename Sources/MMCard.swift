
//
//  File.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/20/16.
//
//


import Foundation
import OCTJSON
import OCTFoundation


class MMCard: MMCardModel {
    
    var key: String = "DEFAULT"
    var id: Int = 0
    var name: String = ""
    
    var attackRule: AttackRule = .melee
    var attackArea: AttackArea = .single
    var attackType: AttackType = .physics
    
    
    var skill1Factor: Float = 0.5
    var skill2Factor: Float = 1.5
    
    
    var ball = 0
    var category = 0
    
    var sp: Int = 5
    var hp: Int = 100
    var atk: Int = 100
    var def: Int = 100
    var mag: Int = 100
    var spd: Int = 100
    
    var baoji: Int = 0
    var shanbi: Int = 0
    var mingzhong: Int = 0
    var gedang: Int = 0
    
    
    var zaisheng: Int = 0
    var xixue: Int = 0
    var fantanwuli: Int = 0
    var fantanfashu: Int = 0
    
    init() {
        
    }
    
    
    
    func willHit(character: MMCharacter, damage: MMDamage) {

    }
    
    
    func hit(character: MMCharacter, damage: MMDamage, allTargets: [MMCharacter]) {
        if damage.skillIndex == 1 {
            character.sp += 1
        } else {
            character.sp = 0
        }

        
//        if damage.skillIndex == 2 {
            for tar in allTargets {
                tar.sp += 1
            }
//        }
        
    }
    
    
    func willBehit(character: MMCharacter, damage: MMDamage) {
        
    }
    
    
    func behit(character: MMCharacter, damage: MMDamage) {
        guard let destination = damage.destination else {
            Logger.error("")
            return
        }
        
        
        _ = makeCalculatedValue(damage: damage, char1: damage.source, char2: destination)
        
        
        destination.hp -= damage.value
        
    }
    
    
    func didBehit(character: MMCharacter, damage: MMDamage) {
        
    }
    
    
    func didHit(character: MMCharacter, mainTargetDamage damage: MMDamage, allTargetDamages: [MMDamage]) {
        if damage.skillIndex == 2 {
            damage.ball = character.card.ball
        }
    }
    
    
    
    
    
    
    
//    func willHit1(character: MMCharacter, player: MMBattlePlayer) {
//        
//    }
//    
//    func hit1(character: MMCharacter, player: MMBattlePlayer) -> MMDamage {
//        
//    }
//    
//    func didHit1(character: MMCharacter, player: MMBattlePlayer, mainDamage: MMDamage, allDamages damages: [MMDamage]) {
//        
//    }
//    
//    
//    func willBehit(character: MMCharacter, player: MMBattlePlayer, damage: MMDamage) {
//        
//    }
//    
//    func behit(character: MMCharacter, player: MMBattlePlayer, damage: MMDamage) {
//        
//    }
//    
//    func didBehit(character: MMCharacter, player: MMBattlePlayer, damage: MMDamage) {
//        
//    }
    
}




//struct MMCardType: MMCardModel {
//    
//    var key: String
//    var id: Int
//    var name: String
//    
//    var attackRule: AttackRule //默认大招小招攻击规则相同
//    var attackArea: AttackArea //大招攻击范围，默认小招攻击范围为.single
//    var attackType: AttackType
//    
//    
//    var skill1Factor: Float
//    var skill2Factor: Float
//    
//    
//    var sp: Int
//    var hp: Int
//    var atk: Int
//    var def: Int
//    var mag: Int
//    var spd: Int
//    
//    var baoji: Int
//    var shanbi: Int
//    var mingzhong: Int
//    var gedang: Int
//    
//    
//    var zaisheng: Int
//    var xixue: Int
//    var fantanwuli: Int
//    var fantanfashu: Int
//    
//    init() {
//        
//    }
//    
//    static func deserilize(fromJSON json: JSON) -> MMCardType? {
//        var card = MMCardType()
//        card.key    = json["key"].string!
//        card.id     = json["id"].int!
//        card.name   = json["name"].string!
//        card.attackRule = AttackRule.deserilize(fromString: json["attackrule"].string!)
//        card.attackArea = AttackArea.deserilize(fromString: json["attackarea"].string!)
//        card.attackType = AttackType.deserilize(fromString: json["attacktype"].string!)
//        
//        
//    }
//    
//}








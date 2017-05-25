////
////  MMFaBao002.swift
////  AAA
////
////  Created by yuhan zhang on 10/29/16.
////  Copyright © 2016 octopus. All rights reserved.
////
//
//import Foundation
//
//
//class MMFaBao002: MMFabaoModel, MMUnitObservable {
//    
//    var key: String = "002"
//    var id: Int = 2
//    var name: String = "一兵不倒"
//    
//    
//    var hp: Int = 100
//    var atk: Int = 0
//    var def: Int = 10
//    var mag: Int = 0
//    var spd: Int = 10
//
//    var baoji: Int = 0
//    var shanbi: Int = 0
//    var mingzhong: Int = 0
//    var gedang: Int = 0
//    
//    
//    var zaisheng: Int = 0
//    var xixue: Int = 0
//    var fantanwuli: Int = 0
//    var fantanfashu: Int = 0
//    
//    
//    func onHPChanged(character: MMCharacter, newValue: inout Int, oldValue: Int) {
//        _ = character.player?.battle?.record.fightState.damage.userInfo.updateValue("yibingbudao", forKey: "reason")
//    }
//    
//    
//}

//
//  MMBattleRecord.swift
//  AAA
//
//  Created by yuhan zhang on 9/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import OCTJSON
import OCTFoundation


#if os(Linux)
    let RecordPath = "/root/Developer/MMBattleServer"
#else
    let RecordPath = "/Users/yorg/Developer/MechanMon"
#endif


class MMBattleRecord {
    
    var battleKey: String!
    var battleID = 1
    var p1JSON: JSON!
    var p2JSON: JSON!
    
    private var roundsJSON = [JSON]()
    private var guardiansJSON = [JSON]()
    
    private var resultJSON: JSON?
    
    
    private var currentGuardiansJSON = [JSON]()
    private var currentRoundStateJSON = [JSON]()
    
    
//    private var fightState: MMFightState!
//    private var beforeFight = [[String: Any]]()
//    private var afterFight = [[String: Any]]()
    
    
    
    private var fightLog: BTFightLog!
    
    
    func putFightLog(log: BTFightLog) {
        self.fightLog = log
    }
    
    
    func putSkill(skill: BTSkill) {
        self.fightLog.skill = skill
    }
    
    
    func putMainDamage(damage: MMDamage) {
        self.fightLog.mainDamage = damage
    }
    
    
    func putSideDamages(damages: [MMDamage]) {
        self.fightLog.sideDamages = damages
    }
    
    
    
    
    
    
    
    
    
    func putBeforeFight(_ dict: [String: Any]) {
//        self.beforeFight.append(dict)
        self.fightLog.beforeFight.append(dict)
    }
    
    
    func putAfterFight(_ dict: [String: Any]) {
//        self.afterFight.append(dict)
        self.fightLog.afterFight.append(dict)
    }
    
    
    
    
    func putResult(_ result: JSON) {
        self.resultJSON = result
    }
    
    
    func pushFightLog() {
        if fightLog != nil {
            fightLog.pin()
            self.currentRoundStateJSON.append(fightLog.json)
            fightLog = nil
        }
    }
    
    
//    func pushFightState() {
//        
//        if fightState != nil {
//            
//            if self.fightState.affectArrayJSON.count > 0 {
//                self.fightState.before = self.beforeFight
//                self.fightState.after = self.afterFight
//                self.currentRoundStateJSON.append(self.fightState.json)
//                
//                self.fightState = nil
//                self.beforeFight = []
//                self.afterFight = []
//                
//            }
//        }
//        
//    }
    
    
//    func pushGuardian() {
//        
//        if currentGuardiansJSON.count > 0 {
//            self.guardiansJSON.append(JSON(currentGuardiansJSON))
//            self.currentGuardiansJSON = []
//        }
//        
//    }
    
    
    func pushRoundState() {
        
        if currentRoundStateJSON.count > 0 {
            self.roundsJSON.append(JSON(currentRoundStateJSON))
            currentRoundStateJSON = []
        }

    }
    
    
    
    
    func end() {
        
//        pushGuardian()
        pushFightLog()
        pushRoundState()
        
        do {
        try self.json.serialize().write(toFile: "\(RecordPath)/Records/\(self.battleKey!)", atomically: false, encoding: String.Encoding.utf8)
        } catch {
            Logger.error("Record Write to File")
        }
        
    }
    

    
    
    var json: JSON {
        if let resultJSON = resultJSON {
            return JSON(["battleid": battleID, "battlekey": battleKey, "player1": self.p1JSON, "player2": self.p2JSON, "rounds": roundsJSON, "guardians": guardiansJSON, "result": resultJSON])
        }
        else {
            return JSON(["battleid": battleID, "battlekey": battleKey, "player1": self.p1JSON, "player2": self.p2JSON, "rounds": roundsJSON, "guardians": guardiansJSON])
        }
    }
    
}




//struct MMGuardianState {
//    
//    var playerKey: String
//    var guardianKey: String
//    
//    
//    var affectArrayJSON = [JSON]()
//    
//    
//    init(playerKey: String, guardianKey: String, affectArray: [MMAffectState]) {
//        self.playerKey = playerKey
//        self.guardianKey = guardianKey
//
//        for affect in affectArray {
//            affectArrayJSON.append(affect.json)
//        }
//        
//    }
//    
//    var json: JSON {
//        
//        let dict: [String: Any] = ["playerkey": playerKey, "guardiankey": guardianKey, "affectarray": affectArrayJSON]
//        return JSON(dict)
//    }
//    
//}




//
//struct MMFightState {
//    
//    var playerKey: String
//    
//    
//    var targetPlayerKey: String = ""
//    var targetCardKey: String = ""
//    var targetCellID: Int = 0
//    
//    
//    var before = [[String: Any]]()
//    var after = [[String: Any]]()
//    
//
//    
//    var affectArrayJSON = [JSON]()
//    
//    var cardKey: String {
//        return damage.source.key
//    }
//    var cellID: Int {
//        return damage.source.position
//    }
//    
//    var skillID: Int {
//        return damage.skillIndex
//    }
//    
//    var sp: Int {
//        return damage.source.sp
//    }
//    
//    var maxSP: Int {
//        return damage.source.maxSP
//    }
//    
//    var hp: Int {
//        return damage.source.hp
//    }
//    
//    var maxHP: Int {
//        return damage.source.maxHP
//    }
//    
//    var userinfo: [String: Any] {
//        return damage.userInfo
//    }
//    
//    
//    
//    var damage: MMDamage!
// 
//    
//    init(fromCharacter char: MMUnit) {
//        self.playerKey = char.player!.key
//    }
//    
//    
//    
//    
//    var json: JSON {  
//        
//        var beforeJSONs = [JSON]()
//        for b in self.before {
//            beforeJSONs.append(JSON(b))
//        }
//        let beforeJSON = JSON(beforeJSONs)
//        
//        var afterJSONs = [JSON]()
//        for a in self.after {
//            afterJSONs.append(JSON(a))
//        }
//        let afterJSON = JSON(after)
//        
//        
//        let dict: [String: Any] = ["playerkey": playerKey,
//                                   "cardkey": cardKey,
//                                   "cellid": cellID,
//                                   "targetplayerkey": targetPlayerKey,
//                                   "targetcardkey": targetCardKey,
//                                   "targetcellid": targetCellID,
//                                   "skillid": skillID,
//                                   "affectarray": affectArrayJSON,
//                                   "sp": self.sp,
//                                   "maxsp": self.maxSP,
//                                   "hp": self.hp,
//                                   "maxhp": self.maxHP,
//                                   "before": beforeJSON,
//                                   "after": afterJSON]
//
//        
//        return JSON(dict + damage.userInfo)
//    }
//    
//}
//
//
//struct MMAffectState {
//    
//    var playerKey: String
//    var cardKey: String {
//        return self.character!.key
//    }
//    var cellID: Int {
//        return self.character!.position
//    }
//    var hitValue: Int {
//        return damage!.value
//    }
//    var maxhp: Int {
//        return self.character!.maxHP
//    }
//    
//    var maxSP: Int {
//        return self.character!.maxSP
//    }
//    
//    var hp: Int {
//        return self.character!.hp
//    }
//    var sp: Int {
//        return self.character!.sp
//    }
//
//    var isBaoji: Bool {
//        return damage!.isBaoji
//    }
//    var isShanbi: Bool {
//        return damage!.isShanbi
//    }
//    var isGedang: Bool {
//        return damage!.isGedang
//    }
//    var isMianyi: Bool {
//        return damage!.isMianyi
//    }
//    
//    var userinfo: [String: Any] {
//        return damage!.userInfo
//    }
//    
//    var damage: MMDamage?
//    
//    var character: MMUnit? {
//        return damage?.destination
//    }
//    
//    init(damage: MMDamage) {
//        self.playerKey = damage.destination!.player!.key
//        self.damage = damage
//    }
//    
//    
//    init(playerKey: String, damage: MMDamage) {
////        self.playerKey = player
////        self.cardKey = damage.destination?.card.key ?? "ERROR"
////        self.cellID = damage.destination?.position ?? 0
////        self.hitValue = damage.value
////        self.hp = damage.destination?.hp ?? 0
////        self.sp = damage.destination?.sp ?? 0
////        self.isBaoji = damage.isBaoji
////        self.isShanbi = damage.isShanbi
////        self.isGedang = damage.isGedang
////        self.isMianyi = damage.isMianyi
////        self.rule = damage.rule
////        self.area = damage.area
////        self.type = damage.type
////        self.userinfo = damage.userInfo
//        
//        self.playerKey = playerKey
//        self.damage = damage
//    }
//    
//    
//    
//    init(playerKey: String) {
//        self.playerKey = playerKey
//    }
//   
//    
//    
//    
//    var json: JSON {
//        
//        let dict: [String: Any] = ["playerkey": playerKey, "cardkey": cardKey, "cellid": cellID, "hitvalue": hitValue, "maxhp": maxhp, "maxsp": maxSP, "hp": hp, "sp": sp, "isbaoji": isBaoji, "isshanbi": isShanbi, "isgedang": isGedang, "ismianyi": isMianyi]
//        
//        
//        
//        return JSON(dict + userinfo)
//    }
//    
//    
//}
//
//
//
//
//
//
//
//
//
//

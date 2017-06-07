//
//  MMPVERepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Foundation
import OCTFoundation
import OCTJSON


class MMPVEFactory {
    
    static func createPVEUnits(index: Int) -> [MMUnit] {
        let mission = index / 100
        
        
        let json: JSON
        let boss: String
        if mission == 0 {
            json = JSON.read(fromFile: "\(MissionPath)/mission_\(index)")!
            boss = json["boss"][0].string!
        }
        else {
            json = JSON.read(fromFile: "\(DungeonPath)/dungeon_\(mission)")!
            let bossIndex = index % 100
            boss = json["boss"][bossIndex].string!
        }
        
        
        
        let simpleCharJSONs = json[kCharacters][boss].array!
        
        
        var char2 = [MMUnit]()
        for simpleJSON in simpleCharJSONs {
            let char = MMUnitFactory.createNPCUnit(key: simpleJSON[kCardKey].stringValue)
            char.position = simpleJSON[kPosition].intValue
            char2.append(char)
        }
        
        
        return char2
    }
    
    
    
   
    
//    static func createPVEBattlePlayer(index: Int) -> MMBattlePlayer {
//        let p2 = MMPlayer(id: "PVE-\(index)")
//        let cells2: [Int]
//        let cards2: [String]
//        
//        switch index {
//        case 101: //
//            cells2 = [4, 6, 9]
//            cards2 = ["lr_shengcun", "ms_shensheng", "ms_anying"]
//        case 102: //
//            cells2 = [4, 6, 9]
//            cards2 = ["lr_shengcun", "ms_shensheng", "ms_anying"]
//        case 103:
//            cells2 = [4, 6, 9]
//            cards2 = ["lr_shengcun", "ms_shensheng", "ms_anying"]
//        case 201:
//            cells2 = [4, 6, 9]
//            cards2 = ["lr_shengcun", "ms_shensheng", "ms_anying"]
//        case 202:
//            cells2 = [4, 6, 9]
//            cards2 = ["ms_jielv", "ms_shensheng", "ms_anying"]
//        case 203:
//            cells2 = [4, 6, 9]
//            cards2 = ["lr_sheji", "ms_shensheng", "ms_anying"]
//        case 7:
//            cells2 = [0, 1, 2, 6, 7, 11, 12, 15]
//            cards2 = ["xuanwu", "fenghou", "taotie", "change", "xingtian", "houyi", "fengbo", "suanyu"]
//        case 8:
//            cells2 = [0, 2, 5, 7, 8, 10, 12, 13, 15]
//            cards2 = ["xuanwu", "xingtian", "taotie", "fenghou", "fengbo", "change", "houyi", "suanyu"]
//        case 9:
//            cells2 = [0, 3, 5, 6, 9, 10, 12, 15]
//            cards2 = ["xuanwu", "fenghou", "taotie", "change", "xingtian", "houyi", "fengbo", "suanyu"]
//        case 11: //云垂
//            cells2 = [1, 2, 4, 7, 8, 11, 12, 15]
//            cards2 = ["xuanwu", "xingtian", "taotie", "fengbo", "houyi", "fenghou", "change", "suanyu"]
//        case 12: //虎翼
//            cells2 = [0, 1, 2, 7, 9, 11, 12, 15]
//            cards2 = ["xuanwu", "xingtian", "taotie", "fengbo", "houyi", "fenghou", "change", "suanyu"]
//        case 13: //蛇盘
//            cells2 = [0, 4, 5, 6, 9, 10, 11, 15]
//            cards2 = ["xuanwu", "fengbo", "taotie", "xingtian", "houyi", "fenghou", "suanyu", "change"]
//        case 14: //风扬
//            cells2 = [1, 5, 6, 7, 8, 9, 10, 15]
//            cards2 = ["xuanwu", "fenghou", "taotie", "change", "xingtian", "houyi", "fengbo", "suanyu"]
//        default:
//            cells2 = [0, 3, 5, 6, 9, 10, 12, 15]
//            cards2 = ["xuanwu", "xingtian", "taotie", "fenghou", "houyi", "fengbo", "change", "suanyu"]
//        }
//        
//        
//        let json = JSON.read(fromFile: "")!
//        
//        let bossIndex = index % 100
//        let boss = json["boss"][bossIndex].stringValue
//        
//        let charJSONs = json[kCharacters][boss].array!
//        
//        let char2 = MMCharacter.deserialize(fromJSONs: charJSONs)
//        
//        
//        
//        let ret = MMBattlePlayer(key: "", characters: char2)
//
//        
//        return ret
//        
//    }
    
    
    
}

//
//  MMCharacterRepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/5/16.
//
//

import Foundation
import OCTJSON
import OCTFoundation


class MMUnitFactory {
//    
//    
//    static var units: [String: MMUnit] = [:]
//    
    
    static func createPVEUnits(index: Int) -> [MMUnit] {
        
        if index >= 1000000 {
            return createMissionUnits(index: index)
        }
        else {
            return createDungeonUnits(index: index)
        }
        
    }
    
    
    static func deserialize(fromJSONs jsons: [JSON]) -> [MMUnit] {
        return jsons.map({ (json) -> MMUnit in
            return MMUnit.deserialize(fromJSON: json)
        })
    }
    
    
    
    
    ///MARK:- Private
    
    
    
    private static func createNPCUnit(key: String) -> MMUnit {

        let file = "\(UnitPath)/\(key)"
        
        let json = JSON.read(fromFile: file)!
        
        let unit = MMUnit.deserialize(fromJSON: json)
//        units.updateValue(unit, forKey: key)
        return unit
        
    }
    
    
    
    private static func createMissionUnits(index: Int) -> [MMUnit] {
        
        let missionIndex = index/1000000
        let characterIndex = (index%1000000)/10000
        
        let json = JSON.read(fromFile: "\(MissionPath)/mission_\(missionIndex)")!
        
        let simpleCharJSONs = json["characters"]["\(characterIndex)"].array!
        
        var char2 = [MMUnit]()
        for simpleJSON in simpleCharJSONs {
            let char = MMUnitFactory.createNPCUnit(key: simpleJSON[kCardKey].stringValue)
            char.position = simpleJSON[kPosition].intValue
            char2.append(char)
        }
        
        
        return char2
    }
    
    
    
    private static func createDungeonUnits(index: Int) -> [MMUnit] {
        
        let dungeonIndex = index/100
        
        let json = JSON.read(fromFile: "\(DungeonPath)/dungeon_\(dungeonIndex)")!
        let bossIndex = index % 100
        let boss = json["boss"][bossIndex].string!
        let simpleCharJSONs = json[kCharacters][boss].array!
        
        
        
        var char2 = [MMUnit]()
        for simpleJSON in simpleCharJSONs {
            let char = MMUnitFactory.createNPCUnit(key: simpleJSON[kCardKey].stringValue)
            char.position = simpleJSON[kPosition].intValue
            char2.append(char)
        }
        
        
        return char2
    }
    
    
}









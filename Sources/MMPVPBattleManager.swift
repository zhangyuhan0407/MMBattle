//
//  MMPVPBattleSystem.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Kitura
import Foundation
import OCTJSON
import OCTFoundation


class MMPVPBattleManager {
    
    
    static var battles = [MMPVPBattle]()
    
    
    static func create(p1: MMBattlePlayer, p2: MMBattlePlayer) -> MMPVPBattle {

        let battle = MMPVPBattle(type: "PVP_\(p1.key)_\(p2.key)", p1: p1, p2: p2)
        p1._battle = battle
        p2._battle = battle
        
        MMPVPBattleManager.battles.append(battle)
        
        return battle
    }
    
    
    static func add(_ battle: MMPVPBattle) {
        battles.append(battle)
    }
    
    
    static func remove(_ battle: MMPVPBattle) {
        battles = battles.filter {
            $0.key != battle.key
        }
    }
    
    
    static func find(_ key: String) -> MMPVPBattle? {
        for b in battles {
            if b.key == key {
                return b
            }
        }
        return nil
    }
    
    
}




protocol OCTMessageQueueType: class {
    
    var queue: [String: [JSON]] { get set }
    
    func add(_ message: JSON, forKey key: String)
    
    func pop(forKey key: String) -> [JSON]
    
}


extension OCTMessageQueueType {
    
    func add(_ message: JSON, forKey key: String) {
        if var msg = queue[key] {
            msg.append(message)
            queue.updateValue(msg, forKey: key)
        } else {
            queue.updateValue([message], forKey: key)
        }
    }
    
    
    func pop(forKey key: String) -> [JSON] {
        guard let message = queue[key] else {
            return []
        }
        
        queue.removeValue(forKey: key)
        return message
    }
    
}














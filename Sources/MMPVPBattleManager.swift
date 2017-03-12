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
        let battle = MMPVPBattle(type: "PVP", p1: p1, p2: p2)
        MMPVPBattleManager.battles.append(battle)
        p1.battle = battle
        p2.battle = battle
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



class MMPVPPlayerManager: NSObject {
    
    static var sharedInstance = MMPVPPlayerManager()
    
    
    var players = [(Int, MMPlayer)]()
    
    let MAX_COUNT = 5
    
    
    func add(_ player: MMPlayer) {
        if let index = index(ofPlayer: player) {
            players[index].0 = MAX_COUNT
            return
        }
        
        players.append((MAX_COUNT, player))
    }
    
    
    func index(ofPlayer player: MMPlayer) -> Int? {
        for i in 0..<players.count {
            if players[i].1 == player {
                return i
            }
        }
        return nil
    }
    
    
    func remove(_ player: MMPlayer) {
        players = players.filter {
            $0.1.key != player.key
        }
    }
    
    
    func removePlayerTimer() {
        print("--------------Remove player--------------")
        for i in 0..<players.count {
            players[i].0 -= 1
        }

        players = players.filter {
            $0.0 > 0
        }
    }

    
    func start() {
        #if os(Linux)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                print("--------------Remove player--------------")
                for i in 0..<self.players.count {
                    self.players[i].0 -= 1
                }
                
                self.players = self.players.filter {
                    $0.0 > 0
                }
            }
        #else
            DispatchQueue.global().async() { [unowned self] in
                while true {
                    self.removePlayerTimer()
                    sleep(3)
                }
            }
        #endif   
        
    }
    
    
    
    
}














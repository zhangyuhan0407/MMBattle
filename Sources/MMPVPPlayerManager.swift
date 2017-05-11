//
//  MMPVPPlayerManager.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/10/16.
//
//

import Kitura
import Foundation
import OCTJSON
import OCTFoundation


class MMPVPPlayerManager: NSObject {
    
    static var sharedInstance = MMPVPPlayerManager()
    
    typealias MMPlayer = String
    
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
            $0.1 != player
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





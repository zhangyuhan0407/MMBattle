//
//  MMBattle.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/20/16.
//
//

import Foundation
import OCTJSON
import OCTFoundation


class MMBattle {
    
    var time: String = Logger.localTime()
    let key: String
    var type: String
    var id = 1
    var p1: MMBattlePlayer
    var p2: MMBattlePlayer
    
    var isGameOver = false
    
    var currentRound = 0
    
    var record = MMBattleRecord()
    
    
    init(type: String, p1: MMBattlePlayer, p2: MMBattlePlayer) {
        self.type = type
        self.key = time + "-" + type
        self.p1 = p1
        self.p2 = p2
        
        self.record.p1JSON = p1.json
        self.record.p2JSON = p2.json
        self.record.battleKey = self.key
    }
    

    
    func start() {
        
        p1.characters.sort{ $0.position < $1.position }
        p2.characters.sort{ $0.position < $1.position }
        
        repeat {
            if currentRound >= 10 {
                isGameOver = true
                self.record.putResult(JSON(["isgameover": true, "winner": p1.key, "loser": p2.key, "winpoints": 100, "losepoints": 100]))
                self.record.end()
                break
            }
            startNextRound()
        } while !isGameOver
        
    }
    
 
    
    func end() {
        
        if isGameOver {
            return
        }
      
        
        let winner: String
        let loser: String
        if !p1.hasAliveCharacter {
            winner = p2.key
            loser = p1.key
        } else if !p2.hasAliveCharacter {
            winner = p1.key
            loser = p2.key
        } else {
            return
        }
        
        
        isGameOver = true
        self.record.putResult(JSON(["isgameover": true, "winner": winner, "loser": loser, "winpoints": 100, "losepoints": 100]))
        self.record.end()
        
    }
    
    
    
    //MARK:- Private Func
    
    
    
    private func startNextRound() {
        
        
        currentRound += 1
        
//        if p1.guardians.count > currentRound - 1 {
//            end()
//            if !isGameOver {
//                p1.guardians[currentRound - 1].act(player: p1)
//            }
//        }
//        
//        if p2.guardians.count > currentRound - 1 {
//            end()
//            if !isGameOver {
//                p2.guardians[currentRound - 1].act(player: p2)
//            }
//        }
//        
//        
//        self.record.pushGuardian()
        
        for _ in 0..<max(p1.characters.count, p2.characters.count) {
            end()
            if !isGameOver {
                p1.act()
            } else {
                break
            }
            
            end()
            if !isGameOver {
                p2.act()
            } else {
                break
            }
        }
        
        p1.reset()
        p2.reset()
        
        self.record.pushRoundState()
        
        
    }
    
    
    
    
}


extension MMBattle {
    
    func enemy(forPlayer player: MMBattlePlayer) -> MMBattlePlayer {
        return player == self.p1 ? p2 : p1
    }
    
}



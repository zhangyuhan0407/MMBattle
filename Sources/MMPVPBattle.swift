//
//  MMPVPBattle.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Kitura
import OCTJSON
import OCTFoundation


class MMPVPBattle: MMBattle {

    var result = [JSON]()
    
    var isP1Ready = false
    var isP2Ready = false
    
    var isReady: Bool {
        return isP1Ready && isP2Ready
    }
    
    
    var p1NewChars = [MMUnit]()
    var p2NewChars = [MMUnit]()
    
    
    func receiveCommand(playerKey: String, characters: [MMUnit], guardian: MMGuardian?) {
        if playerKey == p1.key {
            p1.addCharacters(characters)
            p1NewChars = characters
            
            if let g = guardian {
                p1.guardians = [g]
            } else {
                p1.guardians = []
            }
            
            isP1Ready = true
            
        } else {
            p2.addCharacters(characters)
            p2NewChars = characters
            if let g = guardian {
                p2.guardians = [g]
            } else {
                p2.guardians = []
            }
            
            isP2Ready = true
            
        }
        
        start()
    }
    
    
    
    func findFiratActPlayer() -> MMBattlePlayer {
        return p1.speed > p2.speed ? p1 : p2
    }
    
    
    
    
    override func start() {
        
        let currentRoundJSON = self.recordCurrentRound()
        
        let p1 = findFiratActPlayer()
        let p2 = p1.enemy
        
        p1.characters.sort{ $0.position < $1.position }
        p2.characters.sort{ $0.position < $1.position }
        
        if isReady {
            
            end()
            p1.guardians.last?.act(player: p1)
            end()
            p2.guardians.last?.act(player: p2)
            
            
//            self.record.pushGuardian()
           
            
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
            
            
            var json = self.record.json
            
            
            json["battlekey"] = JSON(self.key)
            json["player1"] = currentRoundJSON["player1"]
            json["player2"] = currentRoundJSON["player2"]
            json["currentround"] = currentRoundJSON["currentround"]
            
            self.result.append(json)
            
            currentRound += 1
        }
        
    }
    
    
    func recordCurrentRound() -> JSON {
        var json = JSON([String: Any]())
        
        let card1Keys = p1NewChars.map { $0.card.key }
        let cell1IDs = p1NewChars.map { $0.position }
        let card1MaxHP = p1NewChars.map { $0.maxHP }
        let card1hp = p1NewChars.map { $0.hp }
        let card1MaxSP = p1NewChars.map { $0.maxSP }
        let card1sp = p1NewChars.map { $0.sp }
        
        
        let card2Keys = p2NewChars.map { $0.card.key }
        let cell2IDs = p2NewChars.map { $0.position }
        let card2MaxHP = p2NewChars.map { $0.maxHP }
        let card2hp = p2NewChars.map { $0.hp }
        let card2MaxSP = p2NewChars.map { $0.maxSP }
        let card2sp = p2NewChars.map { $0.sp }
        
        
        json["player1"] = JSON(["battlekey": self.key,
                                "battleid": self.id,
                                "playerkey": p1.key,
                                "cardkeys": JSON(card1Keys),
                                "cellids": JSON(cell1IDs),
                                "maxhp": JSON(card1MaxHP),
                                "hp": JSON(card1hp),
                                "maxsp": JSON(card1MaxSP),
                                "sp": JSON(card1sp)])
        
        json["player2"] = JSON(["battlekey": self.key,
                                "battleid": self.id,
                                "playerkey": p2.key,
                                "cardkeys": JSON(card2Keys),
                                "cellids": JSON(cell2IDs),
                                "maxhp": JSON(card2MaxHP),
                                "hp": JSON(card2hp),
                                "maxsp": JSON(card2MaxSP),
                                "sp": JSON(card2sp)])
        
        json["currentround"] = JSON(Double(currentRound))
        
        return json
    }
    
    
    func checkGameOver() {
        if isGameOver {
            let winner: String; let loser: String
            if p1.hasAliveCharacter {
                winner = p1.key
                loser = p2.key
            } else {
                winner = p2.key
                loser = p1.key
            }
            
            let dict: [String: Any] = ["isgameover": true, "winner": winner, "winpoints": 10, "loser": loser, "losepoints": 10]
            self.result.append(JSON(dict))
        }
    }
    
    
    func reset() {
        self.isP1Ready = false
        self.isP2Ready = false
        self.record = MMBattleRecord()
        self.record.p1JSON = self.p1.json
        self.record.p2JSON = self.p2.json
        self.record.battleKey = self.key
    }
    
    
    var isTrainingMode: Bool {
        return self.key.hasSuffix("Training")
    }
    
    
}









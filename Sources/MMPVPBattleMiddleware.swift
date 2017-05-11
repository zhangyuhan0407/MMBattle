//
//  MMPVPBattleMiddleware.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Kitura
import OCTJSON
import OCTFoundation


class MMPVPBattleMiddleware: RouterMiddleware {
    
    let messageQueue = MMPVPBattleQueue.sharedInstance
    
    
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        
        guard let json = request.jsonBody else {
            Logger.error(request.headers["host"]! + "\tInput Empty")
            try response.send(OCTResponse.InputEmpty).end()
            return
        }
        
        
        guard let playerKey = json["playerkey"].string,
                let battleKey = json["battlekey"].string,
                let charJSONs = json[kCharacters].array
        else {
            try response.send(OCTResponse.InputFormatError).end()
            return
        }
        
        
//        let guardiankey = json["guardiankey"].string ?? ""
        
        
        let characters = MMUnit.deserialize(fromJSONs: charJSONs)
//        let guardian = MMGuardianRepo.create(key: guardiankey)
        
        
        guard let battle = MMPVPBattleManager.find(battleKey) else {
            Logger.error(request.headers["host"]! + "\tbattle key: \(battleKey) not found")
            try response.send(OCTResponse.ServerError).end()
            return
        }
        
        
        battle.receiveCommand(playerKey: playerKey, characters: characters, guardian: nil)
        
        
        if battle.isTrainingMode {
            if battle.currentRound == 0 {
                let ai = MMBattlePlayerAI()
                battle.receiveCommand(playerKey: ai.key, characters: ai.characters, guardian: nil)
                ai.battle = battle
            } else {
                let chars = MMBattlePlayerAI.rechargeCharacters(round: battle.currentRound)
                battle.receiveCommand(playerKey: "ai", characters: chars, guardian: nil)
            }

        }
        
        
        if battle.isReady {
            
            if let json = battle.result.last {
                messageQueue.add(json, forKey: battle.p1.key)
                messageQueue.add(json, forKey: battle.p2.key)
            }
            
            battle.reset()
            
        }
        
        
        if battle.isGameOver {
            
            battle.checkGameOver()
            if let json = battle.result.last {
                messageQueue.add(json, forKey: battle.p1.key)
                messageQueue.add(json, forKey: battle.p2.key)
            }
            
            MMPVPBattleManager.remove(battle)
            
            MMPVPMatchMiddleware.removePlayer(battle.p1.key)
            MMPVPMatchMiddleware.removePlayer(battle.p2.key)
            
        }
        
        
        try response.send(OCTResponse.Succeed(data: JSON("ok"))).end()
            
        
    }
    
    
}


class MMPVPBattleQueue: OCTMessageQueueType {
    
    static var sharedInstance: MMPVPBattleQueue = MMPVPBattleQueue()
    
    var queue: [String : [JSON]] = [:]
    
}



class MMPVPBattleMessageMiddleware: RouterMiddleware {
    
    let messageQueue = MMPVPBattleQueue.sharedInstance
    
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {

        guard let json = request.jsonBody else {
            Logger.error(request.headers["host"]! + "\tInput Empty")
            try response.send(OCTResponse.InputEmpty).end()
            return
        }
        
        Logger.info(request.headers["host"]! + "\t---\t\(json)")
        
        
        let playerKey = json["playerkey"].string!
        
        
        let message = messageQueue.pop(forKey: playerKey)
        if message.count <= 0 {
            Logger.error(request.headers["host"]! + "\tEmpty for Player: \(playerKey)")
            try response.send(.EmptyResult).end()
            return
        }
        
        Logger.info(JSON(message).description)
        
        try response.send(OCTResponse.Succeed(data: JSON(message))).end()
        
    }
    
}














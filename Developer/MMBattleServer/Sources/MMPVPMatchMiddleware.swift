//
//  MMPVPMatchMiddleware.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Kitura
import Foundation
import OCTJSON
import OCTFoundation


class MMPVPMatchMiddleware: RouterMiddleware {
    
    
    static var players = [String]()
    
    static func hasPlayer(_ player: String) -> Bool {
        return players.contains(player)
    }
    
    
    static func removePlayer(_ player: String) {
        players = players.filter {
            player != $0
        }
    }
    
    
    static func addPlayer(_ player: String) {
        if hasPlayer(player) {
            return
        }
        
        players.append(player)
    }
    
    
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
       
        guard let json = request.jsonBody,
                let playerKey = json["playerkey"].string
        else {
            Logger.error(request.headers["host"]! + "\tInput Format Error\n")
            try response.send(OCTResponse.InputFormatError).end()
            return
        }
        
        
        Logger.info(request.headers["host"]! + "\t\(json)")
        
        
//        let player = MMPlayerRepo.findPlayer(key: playerKey)
        
        
        MMPVPMatchMiddleware.addPlayer(playerKey)
        
        startMatching()
        
        try response.send(OCTResponse.EmptyResult).end()
        
        
    }
    
//    #if os(Linux)
//        static var lock = Lock()
//    #else
//    
//    #endif
    
    static var lock = NSLock()
    
    func startMatching() {
        
        MMPVPMatchMiddleware.lock.lock()
        
        if MMPVPMatchMiddleware.players.count > 1 {
            
            let p1 = MMBattlePlayer(key: MMPVPMatchMiddleware.players[0], characters: [])
            let p2 = MMBattlePlayer(key: MMPVPMatchMiddleware.players[1], characters: [])
            
            let battle = MMPVPBattleManager.create(p1: p1, p2: p2)
            
            let json = JSON(["reason": "matchready",
                             "battlekey": battle.key,
                             "battleid": battle.id,
                             "player1key": p1.key,
                             "player2key": p2.key])
            
            
            
            
            MMPVPMatchQueue.sharedInstance.add(json, forKey: p1.key)
            MMPVPMatchQueue.sharedInstance.add(json, forKey: p2.key)
            
            MMPVPMatchMiddleware.players = []
        }
        
        MMPVPMatchMiddleware.lock.unlock()
        
    }
    
    
}



class MMPVPMatchQueue: OCTMessageQueueType {
    
    static var sharedInstance: MMPVPMatchQueue = MMPVPMatchQueue()
    
    private init() {}
    
    
    var queue: [String : [JSON]] = [:]
    
}


class MMPVPMatchMessageMiddleware: RouterMiddleware {
    
 
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        
        guard let json = request.jsonBody,
                let playerKey = json["playerkey"].string
        else {
            Logger.error(request.headers["host"]! + "\tInput Empty")
            try response.send(OCTResponse.InputFormatError).end()
            return
        }
        
        Logger.info(request.headers["host"]! + "\t---\t\(json)")
        
        
        

        let message = MMPVPMatchQueue.sharedInstance.pop(forKey: playerKey)
        if message.count <= 0 {
            Logger.info(request.headers["host"]! + "\tEmpty Message")
            try response.send(OCTResponse.EmptyResult).end()
            return
        }

        try response.send(OCTResponse.Succeed(data: message[0])).end()

    }

    
}




class MMPVPFriendlyMatchMiddleware: RouterMiddleware {
    
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        
    }
    
    
    
    
    
}





















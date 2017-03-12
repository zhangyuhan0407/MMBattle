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
    
    
//    struct MatchPlayer {
//        var player: MMPlayer
//        var is
//    }
    
    
    static var players = [MMPlayer]()
    
    static func hasPlayer(_ player: MMPlayer) -> Bool {
        for p in players {
            if p.key == player.key {
                return true
            }
        }
        return false
    }
    
    
    static func removePlayer(_ player: MMPlayer) {
        players = players.filter {
            player.key != $0.key
        }
    }
    
    
    static func addPlayer(_ player: MMPlayer) {
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
        
        
        let player = MMPlayerRepo.findPlayer(key: playerKey)
        
        
        MMPVPMatchMiddleware.addPlayer(player)
        
        startMatching()
        
        try response.send(OCTResponse.EmptyResult).end()
        
        
    }
    
    #if os(Linux)
        static var lock = Lock()
    #else
        static var lock = NSLock()
    #endif
    
    func startMatching() {
        
        MMPVPMatchMiddleware.lock.lock()
        if MMPVPMatchMiddleware.players.count > 1 {
            
            let p1 = MMBattlePlayer(player: MMPVPMatchMiddleware.players[0], characters: [], guardian: [])
            let p2 = MMBattlePlayer(player: MMPVPMatchMiddleware.players[1], characters: [], guardian: [])
            
            let battle = MMPVPBattleManager.create(p1: p1, p2: p2)
            
            let json = JSON(["reason": "matchready",
                             "battlekey": battle.key,
                             "battleid": battle.id,
                             "player1key": p1.key,
                             "player2key": p2.key,
                             "cardkeys": ["taotie", "xingtian", "xuanwu", "fengbo", "fenghou", "change", "suanyu", "houyi",
                "dangkang", "leishen", "hundun", "fenghuang", "taowu", "qingniao", "baize", "qiongqi"]])
            
            
            
            
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



extension RouterRequest {
    
    var jsonBody: JSON? {
        do {
            
            guard let s = try self.readString() else {
                return nil
            }
            
            return try JSON.deserialize(s)
            
        } catch {
            return nil
        }
    }
    
}

















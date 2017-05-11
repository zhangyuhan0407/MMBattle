//
//  MMPVPTrainningMiddleware.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Kitura
import OCTJSON
import OCTFoundation


class MMPVPTrainningMiddleware: RouterMiddleware {
    
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        
        guard let json = request.jsonBody else {
            try response.send(OCTResponse.InputEmpty).end()
            Logger.error(request.headers["host"]! + "\tInput Empty")
            return
        }
        
        
        
        let playerKey = json["playerkey"].string!

        
        
        let p1 = MMBattlePlayerFactory.createBattlePlayer(player: playerKey, characters: [])
        let p2 = MMBattlePlayerFactory.createPVPPlayer(forPlayer: playerKey, units: [])
        
        
        
        let battle = MMPVPBattleManager.create(p1: p1, p2: p2)
        
        
        
        
        let dict: [String: Any] = ["battleid": battle.id,
                                   "battlekey": battle.key,
                                   "player1key": p1.key,
                                   "player2key": p2.key]


        try response.send(OCTResponse.Succeed(data: JSON(dict))).end()
       
    }
    
}








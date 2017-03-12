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
        
        guard let s = try request.readString() else {
            try response.send(OCTResponse.InputEmpty).end()
            Logger.error(request.headers["host"]! + "\tInput Empty")
            return
        }
        
        
        do {
            let json = try JSON.deserialize(s)
            let playerKey = json["playerkey"].string!
            let player = MMPlayerRepo.findPlayer(key: playerKey)
            let ai = MMPlayerRepo.findPlayer(key: "ai")
            
            
            let p1 = MMBattlePlayerRepo.createBattlePlayer(player: player, characters: [], guardians: [])
            let p2 = MMBattlePlayerRepo.createBattlePlayer(player: ai, characters: [], guardians: [])
            
            let battle = MMPVPBattleRepo.createPVPBattle(type: "\(playerKey)-PVP-Training", p1: p1, p2: p2)
            
            MMPVPBattleManager.add(battle)
            
            let dict: [String: Any] = ["battleid": battle.id,
                                       "battlekey": battle.key,
                                       "player1key": p1.key,
                                       "player2key": p2.key,
                                        "cardkeys": ["taotie", "xingtian", "houyi", "xuanwu",
                                                     "fengbo", "fenghou", "change", "suanyu",
                "dangkang", "leishen", "hundun", "fenghuang", "taowu", "qingniao", "baize", "qiongqi"]]


            try response.send(OCTResponse.Succeed(data: JSON(dict))).end()
            
        } catch {
            Logger.error(request.headers["host"]! + "\tInput Format Error")
            try response.send(OCTResponse.InputFormatError).end()
        }
        
        
        
    }
    
}


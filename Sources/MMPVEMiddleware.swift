//
//  MMPVEMiddleware.swift
//  MechanMon
//
//  Created by yuhan zhang on 10/31/16.
//
//

import Foundation
import Kitura
import OCTJSON
import OCTFoundation


class MMPVEBattleMiddleware: RouterMiddleware {
    
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {

        guard let s = try request.readString() else {
            try response.send(OCTResponse.InputEmpty).end()
            return
        }
        
        Logger.info(request.headers["host"]! + "\t" + s)
        
        do {
            let json = try JSON.deserialize(s)
            
            guard let playerKey = json["playerkey"].string,
                    let battleID = json["battleid"].int,
                    let cards = json["cards"].stringArray,
                    let cells = json["cells"].intArray
            else {
                Logger.error(request.headers["host"]! + "\tInput Format Error\n\(s)")
                try response.send(OCTResponse.InputFormatError).end()
                return
            }
            
            
            
            let p1 = MMPlayerRepo.findPlayer(key: playerKey)

            
            let characters = MMCharacterRepo.create(cards: cards, fabaos: [], cells: cells)
            
            
            let player1 = MMBattlePlayerRepo.createBattlePlayer(player: p1, characters: characters, guardians: [])
            
            let player2 = MMPVERepo.createPVEBattlePlayer(index: battleID)
            
            let battle = MMBattleRepo.createBattle(type: "\(battleID)", p1: player1, p2: player2)

            battle.start()
            
            try response.send(OCTResponse.Succeed(data: battle.record.json)).end()
            
        } catch {
            Logger.error(request.headers["host"]! + "\tNOT Valid JSON\n\(s)")
            try response.send(OCTResponse.InputFormatError).end()
        }
    }
    
    
}








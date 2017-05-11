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

        guard let playerKey = request.parameters["key"],
            let battleIDKey = request.parameters["battleid"],
            let battleID = Int(battleIDKey)
        else {
            try response.send(OCTResponse.InputEmpty).end()
            return
        }
        
        
        guard let json = request.jsonBody else {
            try response.send(OCTResponse.InputEmpty).end()
            return
        }
        
        
        guard let charJSONs = json[kCharacters].array
        else {
            try response.send(OCTResponse.InputFormatError).end()
            return
        }
        
        
        let characters = MMUnit.deserialize(fromJSONs: charJSONs)
        
        let player1 = MMBattlePlayerFactory.createBattlePlayer(player: playerKey, characters: characters)
        
        let pveUnits = MMPVEFactory.createPVEUnits(index: battleID)
        
        let player2 = MMBattlePlayerFactory.createPVEPlayer(forPlayer: playerKey, units: pveUnits)
        
        
        let battle = MMBattleFactory.createBattle(type: "\(battleID)", p1: player1, p2: player2)

        battle.start()
        
        try response.send(OCTResponse.Succeed(data: battle.record.json)).end()
            
        
    }
    
    
}








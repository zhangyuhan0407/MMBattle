//
//  MMCheckMissionMiddleware.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/2/16.
//
//

import Foundation
import Kitura
import OCTJSON
import OCTFoundation


//class MMPVECheckMissionMiddleware: RouterMiddleware {
//    
//    
//    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
//        
//        let battleid = request.parameters["battleid"] ?? "1"
//        
//        Logger.info(request.headers["host"]! + "\t" + battleid)
//        
//        guard let id = Int(battleid) else {
//            try response.send(OCTResponse.InputEmpty).end()
//            Logger.error(request.headers["host"]! + "\t" + battleid)
//            return
//        }
//        
//        let player = MMPVERepo.createPVEBattlePlayer(index: id)
//        let value = JSON(["characters": player.json])
//        
//        try response.send(OCTResponse.Succeed(data: value)).end()
//        
//    }
//    
//    
//}




//class MMCheckPlayerMiddleware: RouterMiddleware {
//    
//    
//    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
//
//        guard let playerKey = request.parameters["playerkey"],
//            let type = request.parameters["type"] else {
//                try response.send(OCTResponse.InputFormatError).end()
//                return
//        }
//        
//        let json = JSON(["taotie", "xingtian", "houyi", "xuanwu", "fengbo", "fenghou", "change", "suanyu"])
//        
//        try response.send(OCTResponse.Succeed(data: json)).end()
//        
//    }
//    
//    
//}
//
//
//
//class MMCheckAttackRuleMiddleware: RouterMiddleware {
//    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
//        
//    }
//}








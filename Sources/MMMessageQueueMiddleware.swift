////
////  MMMessageQueueMiddleware.swift
////  MechanMon
////
////  Created by yuhan zhang on 11/3/16.
////
////
//
//import Kitura
//
//
//class MMMessageQueueMiddleware: RouterMiddleware {
//    
//    
//    static var messages: [String: [JSON]] = [:]
//    
//    
//    static func addMessage(_ msg: JSON, forPlayer player: String) {
//        if var message = messages[player] {
//            message.append(msg)
//            messages.updateValue(message, forKey: player)
//        } else {
//            messages.updateValue([msg], forKey: player)
//        }
//    }
//    
//    
//    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
//        guard let s = try request.readString() else {
//            try response.send(OCTResponse.InputEmpty).end(); return
//        }
//        
//        do {
//            let json = try JSON.deserialize(s)
//            
//            let playerKey = json["playerkey"].string!
//            
//            guard let message = MMMessageQueueMiddleware.messages[playerKey] else {
//                try response.send(OCTResponse.Succeed(data: JSON("ok"))).end()
//                return
//            }
//            
//            MMMessageQueueMiddleware.messages.removeValue(forKey: playerKey)
//            
//            Logger.info("")
//            Logger.info(JSON(message).description)
//            
//            
//            try response.send(OCTResponse.Succeed(data: JSON(message))).end()
//            
//        } catch {
//            try response.send(OCTResponse.InputFormatError).end()
//        }
//        
//    }
//    
//    
//}

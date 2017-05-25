//
//  MMTestMiddleware.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/2/16.
//
//

import Foundation
import Kitura
import OCTJSON
import OCTFoundation


class MMTestMiddleware: RouterMiddleware {
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        try response.send(OCTResponse.Succeed(data: JSON("OKOKOK"))).end()
    }
}

//
//extension RouterRequest: CustomStringConvertible {
//    public var description: String {
//        var ret = self.headers["host"]! + "\t" + self.method.description
//        
//        switch self.method {
//        case .get:
//            ret = "\(ret)\n\(self.parameters)"
//        case .post:
//            do {
//                let s = try self.readString()!
//                ret = "\(ret)\n\(s)"
//            } catch {
//                return ret
//            }
//            
//        default:
//            return ret
//        }
//        
//        return ret
//    }
//}


extension RouterResponse {
    func send(_ s: OCTResponse) -> RouterResponse {
        return self.send(s.description)
    }
}













//
//  config.swift
//  MechanMon
//
//  Created by yuhan zhang on 5/10/17.
//
//

import Foundation
import OCTJSON
import Kitura


#if os(Linux)
let DungeonPath = "/home/ubuntu/Developer/MMFileServer/dungeons"
let CardPath = "/home/ubuntu/Developer/MMFileServer/cards"
let UnitPath = "/home/ubuntu/Developer/MMFileServer/units"
#else
let DungeonPath = "/Users/yorg/Developer/MMFileServer/dungeons"
let CardPath = "/Users/yorg/Developer/MMFileServer/cards"
let UnitPath = "/Users/yorg/Developer/MMFileServer/units"
#endif



extension JSON {
    var stringValue: String {
        return self.string!
    }
    
    var intValue: Int {
        return self.int!
    }
    
    var boolValue: Bool {
        return self.bool ?? false
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


struct OORandom {
    
    static func happens(inPosibility number: Int) -> Bool {
        if Int.random() < number {
            return true
        }
        
        return false
    }
    
}












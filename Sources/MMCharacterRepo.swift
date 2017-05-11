//
//  MMCharacterRepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/5/16.
//
//

import Foundation
import OCTJSON
import OCTFoundation


//class MMCharacterRepo {
//    
//    static func create(cards: [String], fabaos: [JSON], cells: [Int]) -> [MMCharacter] {
//        var ret = [MMCharacter]()
//        
//        guard cards.count == cells.count else {
//            return ret
//        }
//        
//        
//        for i in 0..<cards.count {
//            
//            let card = MMCardRepo.sharedInstance.cards[cards[i]]!
//            let fabao = MMFaBaoRepo.findOne(key: "")
//            let position = cells[i]
//            
//            
//            let char = MMCharacter(card: card, fabao: fabao, position: position)
//            
//            ret.append(char)
//        }
//        
//        return ret
//        
//    }
//    
//}

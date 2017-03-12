//
//  MMPVERepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Foundation


class MMPVERepo {
    
    static func createPVEBattlePlayer(index: Int) -> MMBattlePlayer {
        let p2 = MMPlayer(id: "PVE-\(index)")
        let cells2: [Int]
        let cards2: [String]
        
        switch index {
        case 1: //
            cells2 = [4, 5, 6, 9]
            cards2 = ["xuanwu", "xuanwu", "xuanwu", "fengbo"]
        case 2: //
            cells2 = [4, 6, 13]
            cards2 = ["xuanwu", "xuanwu", "fengbo"]
        case 3:
            cells2 = [4, 6, 9, 13]
            cards2 = ["xuanwu", "xuanwu", "xuanwu", "fengbo"]
        case 4:
            cells2 = [1, 2, 4, 7, 8, 11, 13, 14]
            cards2 = ["xuanwu", "xingtian", "change", "taotie", "fenghou", "suanyu", "houyi", "fengbo"]
        case 5:
            cells2 = [0, 3, 5, 6, 8, 11, 13, 14]
            cards2 = ["xuanwu", "xingtian", "change", "taotie", "fenghou", "suanyu", "houyi", "fengbo"]
        case 6:
            cells2 = [1, 5, 6, 7, 8, 9, 10, 15]
            cards2 = ["xuanwu", "fenghou", "taotie", "change", "xingtian", "houyi", "fengbo", "suanyu"]
        case 7:
            cells2 = [0, 1, 2, 6, 7, 11, 12, 15]
            cards2 = ["xuanwu", "fenghou", "taotie", "change", "xingtian", "houyi", "fengbo", "suanyu"]
        case 8:
            cells2 = [0, 2, 5, 7, 8, 10, 12, 13, 15]
            cards2 = ["xuanwu", "xingtian", "taotie", "fenghou", "fengbo", "change", "houyi", "suanyu"]
        case 9:
            cells2 = [0, 3, 5, 6, 9, 10, 12, 15]
            cards2 = ["xuanwu", "fenghou", "taotie", "change", "xingtian", "houyi", "fengbo", "suanyu"]
        case 11: //云垂
            cells2 = [1, 2, 4, 7, 8, 11, 12, 15]
            cards2 = ["xuanwu", "xingtian", "taotie", "fengbo", "houyi", "fenghou", "change", "suanyu"]
        case 12: //虎翼
            cells2 = [0, 1, 2, 7, 9, 11, 12, 15]
            cards2 = ["xuanwu", "xingtian", "taotie", "fengbo", "houyi", "fenghou", "change", "suanyu"]
        case 13: //蛇盘
            cells2 = [0, 4, 5, 6, 9, 10, 11, 15]
            cards2 = ["xuanwu", "fengbo", "taotie", "xingtian", "houyi", "fenghou", "suanyu", "change"]
        case 14: //风扬
            cells2 = [1, 5, 6, 7, 8, 9, 10, 15]
            cards2 = ["xuanwu", "fenghou", "taotie", "change", "xingtian", "houyi", "fengbo", "suanyu"]
        default:
            cells2 = [0, 3, 5, 6, 9, 10, 12, 15]
            cards2 = ["xuanwu", "xingtian", "taotie", "fenghou", "houyi", "fengbo", "change", "suanyu"]
        }
        
        
        let char2 = MMCharacterRepo.create(cards: cards2, fabaos: [], cells: cells2)
        
        let ret = MMBattlePlayer(player: p2, characters: char2, guardian: [])

        
        return ret
        
    }
    
    
    
}

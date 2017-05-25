//
//  MMFaBaoRepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Foundation
import OCTJSON
import OCTFoundation


//class MMFaBaoRepo {
//    
//    static func findOne(key: String) -> MMFabaoModel {
//        return MMFaBao000()
//    }
//    
//    
//    static func deserialize(fromJSON json: JSON) -> MMFabaoModel {
//        
//        let key = json["name"].string ?? "DEFAULT_FABAO"
//        
//        var fabao = findOne(key: key)
//        
//        fabao.atk = json["atk"].int ?? 0
//        fabao.def = json["def"].int ?? 0
//        fabao.mag = json["mag"].int ?? 0
//        fabao.spd = json["spd"].int ?? 0
//        fabao.hp = json["hp"].int ?? 0
//        
//        fabao.baoji = json["baoji"].int ?? 0
//        fabao.shanbi = json["shanbi"].int ?? 0
//        fabao.mingzhong = json["mingzhong"].int ?? 0
//        fabao.gedang = json["gedang"].int ?? 0
//        
//        fabao.zaisheng = json["def"].int ?? 0
//        fabao.xixue = json["xixue"].int ?? 0
//        fabao.fantanwuli = json["fantanwuli"].int ?? 0
//        fabao.fantanfashu = json["fantanfashu"].int ?? 0
//        
//        return fabao
//    }
//    
//    
//}

//
//  AttackType.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation



enum MMAttackType: String {
    case physics
    case arcane
    case ice        //冰环
    case fire       //伤害高
    case holy       //鼓舞
    case shadow     //降低怒气
    case lightning  //眩晕
    case nature     //加血
    case evil       //真实伤害
    case none       //no damage
}


enum MMAttackArea: String {
    case main
    case side
    case mainside
}


//
//enum AttackType: CustomStringConvertible {
//    case magic
//    case physics
//    case real
//    case heal
//    case demoralize
//    case poisonous
//    case vulnerable
//    
//    
//    
//    static func deserilize(fromString s: String) -> AttackType {
//        return .physics
//    }
//    
//    var description: String {
//        switch self {
//        case .magic:
//            return "magin"
//        case .physics:
//            return "physics"
//        case .real:
//            return "real"
//        case .heal:
//            return "heal"
//        case .demoralize:
//            return "demoralize"
//        case .poisonous:
//            return "poisonous"
//        case .vulnerable:
//            return "vulnerable"
//        }
//    }
//    
//}
//

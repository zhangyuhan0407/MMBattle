//
//  MMGuardianRepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 12/4/16.
//
//

import Foundation
import OCTJSON
import OCTFoundation


class MMGuardianRepo {
    
    static func create(key: String) -> MMGuardian? {
        switch key {
        case "huimiebodong":
            return MMGDHuiMieBoDong()
        case "quanjunguwu":
            return MMGDQuanJunGuWu()
        case "jiuxiaolongyin":
            return MMGDJiuXiaoLongYin()
        case "zaishenglonghou":
            return MMGDZaiShengLongHou()
        case "zhanyigaoang":
            return MMGDZhanYiGaoAng()
        default:
            Logger.error("unknown key: \(key)")
            return nil
        }
    }
    
}

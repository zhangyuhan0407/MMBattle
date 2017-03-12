//
//  MMCardRepo.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation
import OCTJSON
import OCTFoundation


class MMCardRepo {
    
    static var cards: [String: MMCard] = [:]
    
    
    
    
    static func reload() {
        
        cards.updateValue(FSBingShuang(), forKey: "fs_bingshuang")
        cards.updateValue(FSHuoYan(), forKey: "fs_huoyan")
        cards.updateValue(FSAoShu(), forKey: "fs_aoshu")
        
        cards.updateValue(SSHuiMie(), forKey: "ss_huimie")
        cards.updateValue(SSTongKu(), forKey: "ss_tongku")
        cards.updateValue(SSEMo(), forKey: "ss_emo")
        
        cards.updateValue(MSShenSheng(), forKey: "ms_shensheng")
        cards.updateValue(MSJieLv(), forKey: "ms_jielv")
        cards.updateValue(MSAnYing(), forKey: "ms_anying")
        
        cards.updateValue(DZCiSha(), forKey: "dz_cisha")
        cards.updateValue(DZZhanDou(), forKey: "dz_zhandou")
        cards.updateValue(DZMinRui(), forKey: "dz_minrui")
        
        cards.updateValue(SMYuanSu(), forKey: "sm_yuansu")
        cards.updateValue(SMZengQiang(), forKey: "sm_zengqiang")
        //cards.updateValue(smzhi(), forKey: "sm_zhiliao")
        
        cards.updateValue(LRShengCun(), forKey: "lr_shengcun")
        cards.updateValue(LRSheJi(), forKey: "lr_sheji")
        cards.updateValue(LRShouWang(), forKey: "lr_shouwang")
        
        cards.updateValue(ZSWuQi(), forKey: "zs_wuqi")
        cards.updateValue(ZSKuangBao(), forKey: "zs_kuangbao")
        cards.updateValue(ZSFangYu(), forKey: "zs_fangyu")
        
        cards.updateValue(QSShenSheng(), forKey: "qs_shensheng")
        cards.updateValue(QSFangYu(), forKey: "qs_fangyu")
        cards.updateValue(QSChengJie(), forKey: "qs_chengjie")
        
        
    }
    
    
    
    
    static func deserilize(fromJSON json: JSON) -> MMCard {
        
        let card = cards[json["key"].string!]!

        
        card.id     = json["id"].int ?? 0
        card.name   = json["name"].string ?? "DEFAULT"
        
        card.attackRule = AttackRule.deserilize(fromString: json["attackrule"].string!)
        card.attackArea = AttackArea.deserilize(fromString: json["attackarea"].string!)
        card.attackType = AttackType.deserilize(fromString: json["attacktype"].string!)
        
        card.skill1Factor = json["skill1factor"].float ?? 1.0
        card.skill2Factor = json["skill2factor"].float ?? 1.0
        
        card.sp     = json["sp"].int ?? 3
        card.hp     = json["hp"].int ?? 100
        card.atk    = json["atk"].int ?? 0
        card.def    = json["def"].int ?? 0
        card.mag    = json["mag"].int ?? 0
        card.spd    = json["spd"].int ?? 0
        
        
        card.baoji      = json["baoji"].int ?? 0
        card.shanbi     = json["shanbi"].int ?? 0
        card.mingzhong  = json["mingzhong"].int ?? 0
        card.gedang     = json["gedang"].int ?? 0
        
        card.zaisheng   = json["zaisheng"].int ?? 0
        card.xixue      = json["xixue"].int ?? 0
        card.fantanwuli  = json["fantanwuli"].int ?? 0
        card.fantanfashu = json["fantanfashu"].int ?? 0
        
        
        
        
        return card
        
    }
    
    
    static func findOne(key: String) -> MMCard {
        
        if cards.count == 0 {
            reload()
        }
        
        
        return cards[key] ?? LRSheJi()
        
        
        
//        let card: MMCard
//        
//        switch key {
//        case "taotie":
//            card = MMTaoTie()
//        case "xingtian":
//            card = MMXingTian()
//        case "houyi":
//            card = MMHouYi()
//        case "change":
//            card = MMChangE()
//        case "xuanwu":
//            card = MMXuanWu()
//        case "fengbo":
//            card = MMFengBo()
//        case "fenghou":
//            card = MMFengHou()
//        case "suanyu":
//            card = MMSuanYu()
//            
//        case "qiongqi":
//            card = MMQiongQi()
//        case "baize":
//            card = MMBaiZe()
//        case "taowu":
//            card = MMTaoWu()
//        case "fenghuang":
//            card = MMFengHuang()
//        case "dangkang":
//            card = MMDangKang()
//        case "qingniao":
//            card = MMQingNiao()
//        case "hundun":
//            card = MMHunDun()
//        case "leishen":
//            card = MMLeiShen()
//            
//        default:
//            Logger.error("unknown card: \(key)")
//            card = MMTaoTie()
//        }
        
        
        
    }
    
    
}












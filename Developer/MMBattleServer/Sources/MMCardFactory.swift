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


class MMCardFactory {
    
    private var cards: [String: MMCard] = [:]
    
    static var sharedInstance = MMCardFactory()
    
    private init() {
        reload()
    }
    
    
    func findCard(key: String) -> MMCard {
        
        if key.contains("boss") {
            print("this is boss")
        }
        
        
        if let card = cards[key] {
            return card
        }
        
        let json = JSON.read(fromFile: "\(UnitPath)/\(key)")!
        let card: MMCard
        
        if key.contains("_fs_") {
            card = MMNPC_FS(key: key)
        } else if key.contains("_ms_") {
            card = MMNPC_MS()
        } else if key.contains("_ss_") {
            card = MMNPC_SS(key: key)
        } else if key.contains("_dz_") {
            card = MMNPC_DZ(key: key)
        } else if key.contains("_xd_") {
            card = MMNPC_XD(key: key)
        } else if key.contains("_sm_") {
            card = MMNPC_SM()
        } else if key.contains("_lr_") {
            card = MMNPC_LR(key: key)
        } else if key.contains("_zs_") {
            card = MMNPC_ZS(key: key)
        } else if key.contains("_qs_") {
            card = MMNPC_QS(key: key)
        } else {
            
            let cls = json["cls"].string!
            
            switch cls {
            case "fs_huoyan":
                card = FSHuoYan()
            case "fs_bingshuang":
                card = FSBingShuang()
            case "fs_aoshu":
                card = FSAoShu()
            case "ms_shensheng":
                card = MSShenSheng()
            case "ms_jielv":
                card = MSJieLv()
            case "ms_anying":
                card = MSAnYing()
            case "ss_tongku":
                card = SSTongKu()
            case "ss_huimie":
                card = SSHuiMie()
            case "ss_emo":
                card = SSEMo()
            case "dz_cisha":
                card = DZCiSha()
            case "dz_minrui":
                card = DZMinRui()
            case "dz_zhandou":
                card = DZZhanDou()
            case "xd_xiong":
                card = XDXiong()
            case "xd_mao":
                card = XDMao()
            case "xd_niao":
                card = XDNiao()
            case "xd_zhiliao":
                card = XDZhiLiao()
            case "sm_yuansu":
                card = SMYuanSu()
            case "sm_zengqiang":
                card = SMZengQiang()
            case "sm_zhiliao":
                card = SMZhiLiao()
            case "lr_sheji":
                card = LRSheJi()
            case "lr_shengcun":
                card = LRShengCun()
            case "lr_shouwang":
                card = LRShouWang()
            case "zs_wuqi":
                card = ZSWuQi()
            case "zs_fangyu":
                card = ZSFangYu()
            case "zs_kuangbao":
                card = ZSKuangBao()
            case "qs_chengjie":
                card = QSChengJie()
            case "qs_fangyu":
                card = QSFangYu()
            case "qs_zhiliao":
                card = QSShenSheng()
            default:
                fatalError()
            }
            
        }
        
        
        cards.updateValue(card, forKey: key)
        
        loadCardProperties(fromJSON: json)
        
        return card
        
    }
    
    
    
    
    
    
    
    
    private func reload() {
        
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
        
        cards.updateValue(XDMao(), forKey: "xd_mao")
        cards.updateValue(XDXiong(), forKey: "xd_xiong")
        cards.updateValue(XDNiao(), forKey: "xd_niao")
        cards.updateValue(XDZhiLiao(), forKey: "xd_zhiliao")
        
        cards.updateValue(SMYuanSu(), forKey: "sm_yuansu")
        cards.updateValue(SMZengQiang(), forKey: "sm_zengqiang")
        cards.updateValue(SMZhiLiao(), forKey: "sm_zhiliao")
        
        cards.updateValue(LRShengCun(), forKey: "lr_shengcun")
        cards.updateValue(LRSheJi(), forKey: "lr_sheji")
        cards.updateValue(LRShouWang(), forKey: "lr_shouwang")
        
        cards.updateValue(ZSWuQi(), forKey: "zs_wuqi")
        cards.updateValue(ZSKuangBao(), forKey: "zs_kuangbao")
        cards.updateValue(ZSFangYu(), forKey: "zs_fangyu")
        
        cards.updateValue(QSShenSheng(), forKey: "qs_zhiliao")
        cards.updateValue(QSFangYu(), forKey: "qs_fangyu")
        cards.updateValue(QSChengJie(), forKey: "qs_chengjie")
        
        
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: CardPath)
            for file in files {
                if file.contains(".") {
                    continue
                }
                let json = JSON.read(fromFile: "\(CardPath)/\(file)")!
                loadCardProperties(fromJSON: json)
            }
        } catch {
            fatalError()
        }
        
        
        
    }
    
    
    
    
    @discardableResult
    private func loadCardProperties(fromJSON json: JSON) -> MMCard {
        
        let card = cards[json["key"].stringValue]!

        
        card.key = json["key"].string!
        card.id     = json["id"].intValue
        card.name   = json[kName].stringValue
        
//        card.attackRule = AttackRule.deserilize(fromString: json["attackrule"].string!)
//        card.attackArea = AttackArea.deserilize(fromString: json["attackarea"].string!)
        
        card.attackType = MMAttackType(rawValue: json[kAttackType].string ?? "none")!
        
        card.skill1Factor = json["skill1factor"].intValue
        card.skill2Factor = json["skill2factor"].intValue
        
        
        card.sp     = json["maxsp"].int ?? json["sp"].int!
        card.hp     = json["maxhp"].int ?? json["hp"].int!
        
        
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
    
    
    
}












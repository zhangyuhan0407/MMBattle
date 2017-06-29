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
    
    
    
    func findCard(forCls cls: String) -> MMCard {
        if let c = self.cards[cls] {
            return c
        }
        
        let card: MMCard
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
        
        
        cards.updateValue(MMNPC_FS(), forKey: "fs_normal")
        cards.updateValue(MMNPC_MS(), forKey: "ms_normal")
        cards.updateValue(MMNPC_SS(), forKey: "ss_normal")
        cards.updateValue(MMNPC_DZ(), forKey: "dz_normal")
        cards.updateValue(MMNPC_XD(), forKey: "xd_normal")
        cards.updateValue(MMNPC_LR(), forKey: "lr_normal")
        cards.updateValue(MMNPC_SM(), forKey: "sm_normal")
        cards.updateValue(MMNPC_QS(), forKey: "qs_normal")
        cards.updateValue(MMNPC_ZS(), forKey: "zs_normal")
    }
    
    
    
    
}












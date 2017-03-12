//
//  MMGuardian.swift
//  MechanMon
//
//  Created by yuhan zhang on 9/20/16.
//
//

import Foundation


protocol MMGuardian {
    
    var key: String { get }
    var id: Int { get }
    var name: String { get }
    
    
    func act(player: MMBattlePlayer)
    
}












//
//  MMBattlePlayerRepo.swift
//  MechanMon
//
//  Created by yuhan zhang on 11/3/16.
//
//

import Foundation


class MMBattlePlayerFactory {
    
    static func createBattlePlayer(player: String, characters: [MMCharacter]) -> MMBattlePlayer {
        let battlePlayer = MMBattlePlayer(key: player, characters: characters)
        
        for char in battlePlayer.characters {
            char.player = battlePlayer
        }
        
        return battlePlayer
    }
    
    
    static func createPVPPlayer(forPlayer key: String, units: [MMUnit]) -> MMBattlePlayer {
        let battlePlayer = MMBattlePlayer(key: "\(key)_PVP_AI", characters: units)
        
        for char in battlePlayer.characters {
            char.player = battlePlayer
        }
        
        return battlePlayer
    }
    
    
    static func createPVEPlayer(forPlayer key: String, units: [MMUnit]) -> MMBattlePlayer {
        let battlePlayer = MMBattlePlayer(key: "\(key)_PVE_AI", characters: units)
        
        for char in battlePlayer.characters {
            char.player = battlePlayer
        }
        
        return battlePlayer
    }
    
}






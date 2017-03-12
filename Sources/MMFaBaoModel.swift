//
//  MMFaBaoModel.swift
//  AAA
//
//  Created by yuhan zhang on 10/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


protocol MMFabaoModel {
    
    var key: String { get set }
    var id: Int { get set }
    var name: String { get set }
    
    
    
    var hp: Int { get set }
    var atk: Int { get set }
    var def: Int { get set }
    var mag: Int { get set }
    var spd: Int { get set }
    
    var baoji: Int { get set }
    var shanbi: Int { get set }
    var mingzhong: Int { get set }
    var gedang: Int { get set }
    
    var zaisheng: Int { get set }
    var xixue: Int { get set }
    var fantanwuli: Int { get set }
    var fantanfashu: Int { get set }
    
    
}


class MMFaBao000: MMFabaoModel {
    var key: String = "000"
    var id: Int = 0
    var name: String = "默认法宝"
    
    
    var hp: Int = 0
    var atk: Int = 0
    var def: Int = 0
    var mag: Int = 0
    var spd: Int = 0
    
    var baoji: Int = 0
    var shanbi: Int = 0
    var mingzhong: Int = 0
    var gedang: Int = 0
    
    
    var zaisheng: Int = 0
    var xixue: Int = 0
    var fantanwuli: Int = 0
    var fantanfashu: Int = 0
}

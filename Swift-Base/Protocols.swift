//
//  Protocols.swift
//  Swift-Base
//
//  Created by Kruperfone on 19.11.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import Foundation

func + <K,V>(inout left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map.updateValue(v, forKey: k)
    }
    for (k, v) in right {
        map.updateValue(v, forKey: k)
    }
    return map
}

func += <K,V>(inout left: Dictionary<K,V>, right: Dictionary<K,V>) {
    let map = left + right
    left = map
}

//
//  Cache.swift
//  Astronomy
//
//  Created by Joe Veverka on 6/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class Cache<Key: Hashable, Value> {

    //MARK: -Private

    private var store: [Key : Value] = [:]

    //MARK: -Public

    func cahce(_ value: Value, for key: Key) {
        store[key] = value
    }

    func value(for key: Key) -> Value? {
        return store[key]
    }
}

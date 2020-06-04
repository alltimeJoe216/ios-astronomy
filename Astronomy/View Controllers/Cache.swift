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
    private let queue = DispatchQueue(label: "Cachce Queue")

    //MARK: -Public

    func cahce(_ value: Value, for key: Key) {
        queue.async {
            self.store[key] = value
        }
    }

    func value(for key: Key) -> Value? {
        queue.sync {store[key]}
    }
}

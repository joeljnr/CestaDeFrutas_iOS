//
//  FruitRepository.swift
//  Cesta de frutas
//
//  Created by Joel Júnior on 27/01/20.
//  Copyright © 2020 jnr. All rights reserved.
//

import Foundation
import KeychainSwift

let fruitRepository = FruitRepository()

class FruitRepository {
        
    let keychain = KeychainSwift()
    
    func getFruits() -> [Fruit] {
        
        var fruits = [Fruit]()
        
        for key in keychain.allKeys {
            fruits.append(Fruit(name: key))
        }
        
        return fruits
    }
    
    func insert(fruit: Fruit) {
        if let data = fruit.name.data(using: .utf8) {
            keychain.set(data, forKey: fruit.name)
        }
    }
    
    func delete(fruit: Fruit) {
        keychain.delete(fruit.name)
    }
}

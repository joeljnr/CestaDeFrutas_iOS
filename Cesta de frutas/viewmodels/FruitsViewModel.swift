//
//  FruitsViewModel.swift
//  Cesta de frutas
//
//  Created by Joel Júnior on 27/01/20.
//  Copyright © 2020 jnr. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FruitsViewModel {
    
    var dataSource = BehaviorRelay(value: [Fruit]())
    
    init() {
        dataSource.accept(fruitRepository.getFruits())
    }
    
    func insert(fruit: Fruit) {
        fruitRepository.insert(fruit: fruit)
        dataSource.accept(fruitRepository.getFruits())
    }
    
    func delete(fruit: Fruit) {
        fruitRepository.delete(fruit: fruit)
        dataSource.accept(fruitRepository.getFruits())
    }
}

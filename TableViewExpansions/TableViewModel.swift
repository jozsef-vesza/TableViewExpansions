//
//  TableViewModel.swift
//  TableViewExpansions
//
//  Created by Vesza Jozsef on 05/05/15.
//  Copyright (c) 2015 Vesza Jozsef. All rights reserved.
//

import UIKit

class TableViewModel {
    
    private let mainModel = [
        "Item 0",
        "Item 1",
        "Item 2",
    ]
    
    private let detailsModel = [
        "Details 0",
        "Details 1",
        "Details 2",
    ]
    
    func count() -> Int {
        return mainModel.count
    }
    
    func itemForIndex(index: Int) -> String {
        return mainModel[index]
    }
    
    func detailsForIndex(index: Int) -> String {
        return detailsModel[index]
    }
}
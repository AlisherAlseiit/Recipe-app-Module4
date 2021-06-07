//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Алишер Алсейт on 06.06.2021.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipies = [Recipe]()
    
    init() {
        
        
        self.recipies = DataService.getLocalData()
    }
}

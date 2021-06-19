//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Алишер Алсейт on 06.06.2021.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipies = [Recipe]()
    @Published var categories = Set<String>()
    @Published var selectedCategory: String?
    
    init() {
        
        
        self.recipies = DataService.getLocalData()
        
        // MARK: -  Set filter outs all duplicate categories, instead of 2 italian categories it will contain 1
        self.categories = Set(recipies.map { r in
            return r.category
        })
        self.categories.update(with: Constants.defaultListFiltes)
    }
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            
            denominator *= recipeServings
            
            numerator *= targetServings
            
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            if numerator >= denominator {
                
                // Calculated whole portions
                wholePortions = numerator / denominator
                
                // Calculated the reminder
                numerator = numerator % denominator
                
                
                portion += String(wholePortions)
            }
            
            if numerator > 0 {
                
                portion += wholePortions > 0 ? " " : ""
                portion += "\(numerator) /\(denominator) "
            }
            
        }
        
        if var unit = ingredient.unit {
            
            
            
            if wholePortions > 1 {
                
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                    
                }
                else {
                    unit += "s"
                }
            }
            
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            return portion + unit
            
        }
        
        return portion
    }
}

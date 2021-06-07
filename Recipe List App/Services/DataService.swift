//
//  DataService.swift
//  Recipe List App
//
//  Created by Алишер Алсейт on 06.06.2021.
//

import Foundation

class DataService {
    
   static func getLocalData() -> [Recipe] {
        
        
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        
        guard pathString != nil else {
            return [Recipe]()
        }
        
            let url = URL(fileURLWithPath: pathString!)
            
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                
                do{
                    let recipeData =  try decoder.decode([Recipe].self, from: data)
                    
                    for r in recipeData {
                        r.id = UUID()
                    }
                    
                    return recipeData
                    
                }
                catch {
                   print(error)
                }
               
            }
            catch {
                print(error)
            }
            
            
            
            return [Recipe]()
        
    }
    
}

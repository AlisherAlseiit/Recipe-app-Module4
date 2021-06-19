//
//  ContentView.swift
//  Recipe List App
//
//  Created by Алишер Алсейт on 06.06.2021.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var model:RecipeModel
    
    private var title: String {
        
        if model.selectedCategory == nil || model.selectedCategory == Constants.defaultListFiltes {
            return "All Recipies"
        }
        else {
            return model.selectedCategory!
        }
    }
    
    var body: some View {
        
        
        
        NavigationView {
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .padding(.top, 40)
                    .font(Font.custom("Avenir Heavy", size: 24))
                
                ScrollView {
                    
                    LazyVStack(alignment: .leading) {
                        ForEach(model.recipies) { r in
                            
                            if model.selectedCategory == nil || model.selectedCategory == Constants.defaultListFiltes
                                || model.selectedCategory != nil && r.category == model.selectedCategory {
                                
                                
                                NavigationLink(
                                    destination: RecipeDetailView(recipe: r),
                                    label: {
                                        
                                        // MARK: Row item
                                        HStack(spacing: 20.0) {
                                            Image(r.image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .clipped()
                                                .cornerRadius(5)
                                            VStack(alignment: .leading) {
                                                Text(r.name)
                                                    .foregroundColor(.black)
                                                    .font(Font.custom("Avenir Heavy", size: 16))
                                                RecipeHighlights(highlights: r.highlights)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                    })
                                
                            }
                        }
                    }
                }
                
                
            }
            .navigationBarHidden(true)
            .padding(.leading)
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .previewDevice("iPhone 12")
            .environmentObject(RecipeModel())
    }
}

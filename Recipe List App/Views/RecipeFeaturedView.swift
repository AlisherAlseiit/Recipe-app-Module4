//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Алишер Алсейт on 08.06.2021.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Featured Recipies")
                .bold()
                .padding(.leading)
                .padding(.top, 40)
                .font(Font.custom("Avenir Heavy", size: 24))
            
            
            
            GeometryReader { geo in
                
                TabView(selection: $tabSelectionIndex) {
                    
                    ForEach (0..<model.recipies.count) { index in
                        
                        if model.recipies[index].featured {
                            
                            Button(action: {
                                self.isDetailViewShowing = true
                                
                                
                            }, label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                    
                                    
                                    VStack(spacing: 0) {
                                        Image(model.recipies[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(model.recipies[index].name)
                                            .padding(5)
                                            .font(Font.custom("Avenir", size: 15))
                                        
                                    }
                                }
                            })
                            .tag(index)
                            .sheet(isPresented: $isDetailViewShowing) {
                                
                                RecipeDetailView(recipe: model.recipies[index])
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                            .cornerRadius(15)
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Preparation Time")
                    .font(Font.custom("Avenir Heavy", size: 16))
                Text(model.recipies[tabSelectionIndex].prepTime)
                    .font(Font.custom("Avenir", size: 15))
                Text("Highlightes")
                    .font(Font.custom("Avenir Heavy", size: 16))
                RecipeHighlights(highlights:model.recipies[tabSelectionIndex].highlights )
            }
            .padding([.leading, .bottom])
        }
        .onAppear(perform: {
            setFeaturedIndex()
        })
        
    }
    
    
    
    // MARK: find First Index
    func setFeaturedIndex() {
        
        let index =  model.recipies.firstIndex { (recipe) -> Bool in
            return recipe.featured
        }
        tabSelectionIndex = index ?? 0
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}

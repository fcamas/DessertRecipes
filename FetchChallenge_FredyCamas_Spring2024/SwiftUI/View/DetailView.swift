//
//  DetailView.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//

import SwiftUI

struct DetailView: View {
    
    var meal: MealLocalData
    @StateObject var mealDetail =  DessertViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                GeometryReader{ geometry in
                    
                    AsyncImage(url: URL(string: meal.urlImage )) { image in
                        image.resizable()
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -geometry.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height: max(0, min(CGFloat.infinity, geometry.frame(in: .global).minY + ExpandedViewSizes().minY)))
                            .shadow(radius: ExpandedViewSizes().shadowRadius)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: ExpandedViewSizes().cornerRadius)
                            .offset(y: -geometry.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height: max(0, min(CGFloat.infinity, geometry.frame(in: .global).minY + ExpandedViewSizes().minY)))
                        
                            .shadow(radius: ExpandedViewSizes().shadowRadius)
                            .foregroundColor(.gray)
                    }
                }
                .frame(height: ExpandedViewSizes().headerFrame)
                
                VStack(alignment: .leading,spacing: 15){
                    
                    Text(meal.name)
                        .font(.system(size: 35, weight: .bold))
                    
                    Text("Instructions")
                        .font(.system(size: 25, weight: .bold))
                    
                    Text(mealDetail.detailMeal.first?.instructions ?? "loading")
                        .padding(.all)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                    Text("Ingredients/measurements")
                        .font(.system(size: 25, weight: .bold))
                        .bold()
                    
                    ForEach(0..<min(mealDetail.detailMeal.first?.ingredients?.count ?? 0, mealDetail.detailMeal.first?.measures?.count ?? 0 ), id: \.self) { index in
                        HStack {
                            Text(mealDetail.detailMeal.first?.ingredients?[index] ?? "")
                            Spacer()
                            Text(mealDetail.detailMeal.first?.measures?[index] ?? "")
                        }
                    }.padding()
                    
                }
                .background(Color.white)
                .cornerRadius(20)
            })
            
            Spacer()
            
        }.foregroundColor(.black)
            .onAppear{
                mealDetail.fetchDessertDetail(id: meal.id)
            }
    }
}

#Preview {
    DetailView(meal: MealLocalData(meals: Meals()))
}


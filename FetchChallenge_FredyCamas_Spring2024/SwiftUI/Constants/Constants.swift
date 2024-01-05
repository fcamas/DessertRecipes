//
//  Constants.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//

import SwiftUI

struct DessertViewConstants{
    let dessertImageURL = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
}

struct DessertCardSizes{
    var height = UIScreen.main.bounds.height*0.25
    var width = UIScreen.main.bounds.width*9
    var corneRadius:CGFloat = 20
    var shadow:CGFloat = 10
    var leading: CGFloat = 20
}

struct MainViewSizes{
    
    var searchDelay = 0.5
    
    var rectangleStrokeLineWidth:CGFloat = 1
    var rectangleFrame:CGFloat = 50
    var rectangleConerRadius:CGFloat = 20
    
    var cardFrame:CGFloat = 300
}

struct ExpandedViewSizes{
    
    var minY:CGFloat = 300
    var shadowRadius:CGFloat = 10
    var cornerRadius:CGFloat = 10
    var headerFrame:CGFloat = 250
}

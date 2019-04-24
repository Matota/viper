//
//  NeumData.swift
//  Neum
//
//  Created by Hitesh Ahuja on 24/04/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import Foundation

enum CategoryInfoKey: Int, CaseIterable {
    case ac
    case electrical
    case painting
    case parkingshade
    case pestcontrol
    case plastering
    case plumbing
    case roomcooling
    
    //title
    func description() -> String {
        switch self {

        case .ac:
            return "ac"
        case .electrical:
            return "electrical"
        case .painting:
            return "painting"
        case .parkingshade:
            return "parkingshade"
        case .pestcontrol:
            return "pestcontrol"
        case .plastering:
            return "plastering"
        case .plumbing:
            return "plumbing"
        case .roomcooling:
            return "roomcooling"
        }
    }
    
    //image name
    func categoryImageName() -> String{
        switch self {

        case .ac:
            return "ac"
        case .electrical:
            return "electrical"
        case .painting:
            return "painting"
        case .parkingshade:
            return "parkingshade"
        case .pestcontrol:
            return "pestcontrol"
        case .plastering:
            return "plastering"
        case .plumbing:
            return "plumbing"
        case .roomcooling:
            return "roomcooling"
        }
    }
}

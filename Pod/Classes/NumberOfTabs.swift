//
//  NumberOfTabs.swift
//  Pods
//
//  Created by Eric Vennaro on 10/4/16.
//
//

import Foundation

///enum with the cases corresponding to the number of tabs you wish to display
public enum NumberOfTabs {
    case two, three, four
    
    static func enumFor(integer: Int) -> NumberOfTabs {
        switch integer {
        case 2:
            return .two
        case 3:
            return .three
        case 4:
            return .four
        default:
            NSLog("Error: incorrect number of items in array")
            return .two
        }
    }
}

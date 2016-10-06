//
//  AnimateTransition.swift
//  Pods
//
//  Created by Eric Vennaro on 10/5/16.
//
//

import Foundation

///Animation protocol
protocol AnimateTransition {
    ///tracks the currently highlighted button
    var currentState: Int { get set }
    /**
     Controls button animation
     
     - Parameter newState: Int, corresponding to the buttons tag
     */
    func animate(to newState: Int)
}

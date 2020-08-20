//
//  GameClass.swift
//  Memorize
//
//  Created by Hugo Santiago on 20/08/20.
//  Copyright © 2020 Hugo Santiago. All rights reserved.
//

import Foundation
import SwiftUI

struct GameClass: Identifiable {
    var id: Int
    var name:String
    var emojis:[String]
    var color: Color
    
    init(id:Int, name:String, emojis:[String], color:Color) {
        self.id = id
        self.name = name
        self.emojis = emojis
        self.color = color
    }
}

let halloween = GameClass(id: 1, name: "Halloween", emojis: ["👻","🎃", "🕷", "🙀","💀","🤡","🧠","🦹🏼‍♀️"], color: Color.orange)
let animal = GameClass(id: 2, name: "Animals", emojis: ["🐶","🐱","🐭","🦁","🐼","🐸","🐔","🦆"], color: Color.red)
let sport = GameClass(id: 3, name: "Sports", emojis: ["⚽️","🏈","🏸","🏒","🏉","🪁","🥅","🏂"], color: Color.blue)
let fruit = GameClass(id: 4, name: "Fruits", emojis: ["🍏","🍎","🍊","🥑","🍓","🍠","🍖","🥝"], color: Color.green)

let games = [halloween, animal, sport, fruit]

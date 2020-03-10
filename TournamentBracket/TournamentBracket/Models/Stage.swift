//
//  Stage.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 10/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

enum Stage: String, Decodable {
    case final = "Final"
    case semifinal = "Semifinal"
    case quarterfinal = "Quarterfinal"
    case roundOf16 = "Round of 16"
}

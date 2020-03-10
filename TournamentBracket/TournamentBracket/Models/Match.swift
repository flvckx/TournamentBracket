//
//  Match.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 10/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

struct Match: Decodable {
    let matchId: Int
    let homeTeam: String
    let awayTeam: String
    let stage: Stage
    let seed: Int

    enum CodingKeys: String, CodingKey {
        case matchId = "match_id"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case stage
        case seed
    }
}

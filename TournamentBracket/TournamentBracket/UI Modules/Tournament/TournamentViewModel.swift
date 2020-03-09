//
//  TournamentViewModel.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 09/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

protocol ITournamentViewModel {
    var pairsCount: Int { get }
}

final class TournamentViewModel: ITournamentViewModel {

    let pairsCount: Int

    init(pairsCount: Int) {
        self.pairsCount = pairsCount
    }
}

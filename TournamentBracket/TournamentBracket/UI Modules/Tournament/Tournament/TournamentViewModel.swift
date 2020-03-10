//
//  TournamentViewModel.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 09/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

import UIKit

protocol ITournamentViewModel: UITableViewDataSource, UITableViewDelegate {
    var isFirstRound: Bool { get }
    var isFinalRound: Bool { get }
    var contentOffset: CGPoint? { get set }
    var cellHeight: CGFloat { get set }
}

final class TournamentViewModel: NSObject, ITournamentViewModel {

    private let pairsCount: Int

    var isFirstRound: Bool
    var isFinalRound: Bool
    var contentOffset: CGPoint?
    var cellHeight: CGFloat = 122


    init(pairsCount: Int,
         isFirstRound: Bool,
         isFinalRound: Bool) {
        self.pairsCount = pairsCount
        self.isFirstRound = isFirstRound
        self.isFinalRound = isFinalRound
    }
}

// MARK: - UITableViewDataSource

extension TournamentViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pairsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.tournamentCell.identifier, for: indexPath)

        guard let tournamentCell = cell as? TournamentCell else { return cell }

        tournamentCell.isFirstRound = isFirstRound
        tournamentCell.isFinal = isFinalRound
        tournamentCell.isFirstPairGame = indexPath.row % 2 == 0
        tournamentCell.drawBrackets()

        return tournamentCell
    }
}

// MARK: - UITableViewDelegate

extension TournamentViewModel: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

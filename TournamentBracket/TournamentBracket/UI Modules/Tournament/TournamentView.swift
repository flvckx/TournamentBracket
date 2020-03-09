//
//  TournamentView.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 09/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

import UIKit

final class TournamentView: UIViewController {

    @IBOutlet private var tableView: UITableView!

    var viewModel: ITournamentViewModel!

    override func loadView() {
        super.loadView()

        setUpTableView()
    }
}

// MARK: - UITableViewDataSource

extension TournamentView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pairsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.tournamentCell.identifier, for: indexPath)

        guard let tournamentCell = cell as? TournamentCell else { return cell }

        return tournamentCell
    }
}

// MARK: - UITableViewDelegate

extension TournamentView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
}

// MARK: - Private

private extension TournamentView {

    func setUpTableView() {
        tableView.separatorStyle = .none

        let tournamentCellNib = UINib(nibName: R.nib.tournamentCell.name, bundle: R.nib.tournamentCell.bundle)
        tableView.register(tournamentCellNib, forCellReuseIdentifier: R.nib.tournamentCell.identifier)
    }
}

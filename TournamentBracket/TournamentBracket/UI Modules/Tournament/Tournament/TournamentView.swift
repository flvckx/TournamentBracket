//
//  TournamentView.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 09/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

import UIKit

protocol ITournamentView {
    var onDisappear: ((_ contentOffset: CGPoint) -> Void)? { get set }
}

final class TournamentView: UIViewController, ITournamentView {

    @IBOutlet private var tableView: UITableView!

    var viewModel: ITournamentViewModel!

    var onDisappear: ((CGPoint) -> Void)?

    override func loadView() {
        super.loadView()
        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [unowned self] in
            self.tableView.setContentOffset(self.viewModel.contentOffset ?? .zero, animated: false)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDisappear?(tableView.contentOffset)
    }
}

// MARK: - Private

private extension TournamentView {

    func setUpTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.black()

        let tournamentCellNib = UINib(nibName: R.nib.tournamentCell.name, bundle: R.nib.tournamentCell.bundle)
        tableView.register(tournamentCellNib, forCellReuseIdentifier: R.nib.tournamentCell.identifier)
    }
}

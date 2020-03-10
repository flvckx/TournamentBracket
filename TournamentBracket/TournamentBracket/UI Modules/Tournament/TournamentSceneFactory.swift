//
//  TournamentSceneFactory.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 09/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

final class TournamentSceneFactory: SceneFactory {

    typealias Scene = (view: Presentable, viewModel: ITournamentViewModel)

    func scene(pairsCount: Int, isFirstRound: Bool = false, isFinalRound: Bool = false) -> Scene {
        let viewModel = TournamentViewModel(
            pairsCount: pairsCount,
            isFirstRound: isFirstRound,
            isFinalRound: isFinalRound
        )

        guard let view = R.storyboard.tournament.tournamentView() else {
            fatalError("Unable to initiate controller with ID: tournamentView")
        }
        view.viewModel = viewModel

        return (view: view, viewModel: viewModel)
    }
}

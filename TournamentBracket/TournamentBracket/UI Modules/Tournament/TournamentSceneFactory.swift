//
//  TournamentSceneFactory.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 09/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

final class TournamentSceneFactory: SceneFactory {

    typealias Scene = (view: Presentable, viewModel: ITournamentViewModel)

    func scene(matches: [Match], isFirstRound: Bool = false, isFinalRound: Bool = false) -> Scene {
        let viewModel = TournamentViewModel(
            matches: matches,
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

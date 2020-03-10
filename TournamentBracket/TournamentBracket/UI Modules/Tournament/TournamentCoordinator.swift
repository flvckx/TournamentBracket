//
//  TournamentCoordinator.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 07/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

import UIKit

fileprivate let firstRoundPairsCount = 16

final class TournamentCoordinator: Coordinatable & CoordinatorFinishable {

    private let router: Routable
    private let applicationServices: IAppServices

    private let pagesSceneFactory: PageViewSceneFactory
    private let tournamentSceneFactory: TournamentSceneFactory
    
    var finishFlow: ((Any?) -> Void)?
    
    init(router: Routable, applicationServices: IAppServices) {
        self.router = router
        self.applicationServices = applicationServices

        self.pagesSceneFactory = PageViewSceneFactory()
        self.tournamentSceneFactory = TournamentSceneFactory()
    }
    
    func start() {
        showPageView()
    }

    private func showPageView() {
        let matchesRounds = json()
        let rounds = matchesRounds.count // Int(log2(Double(firstRoundPairsCount)))
        var scene = pagesSceneFactory.scene()

        for roundNumber in 0...rounds - 1 {
            let coef = Int(pow(2, Double(roundNumber)))
            let tournamentScene = tournamentSceneFactory.scene(
                matches: matchesRounds[roundNumber].sorted(by: { $0.matchId > $1.matchId }),
                isFirstRound: roundNumber == 0,
                isFinalRound: roundNumber == rounds - 1
            )

            guard let tournamentView = tournamentScene.view.toPresent as? TournamentView else { return }

            tournamentView.viewModel.cellHeight *= CGFloat(coef)
            tournamentView.onDisappear = { contentOffset in
                scene.viewModel.contentOffset = contentOffset
            }
            scene.viewModel.pages.append(tournamentView)
        }

        router.setRootModule(scene.view)
    }
}

// JSON

private extension TournamentCoordinator {

    func json() -> [[Match]] {
        let fileName = R.file.world_cup_playoff_treeJson.name
        guard let matchesResponse = JSONParser<MatchesResponse>.parseFileNamed(fileName) else { return [] }

        let matchesRounds = Dictionary(grouping: matchesResponse.matches, by: { $0.stage })
        return Array(matchesRounds).map { $0.value }.sorted(by: { $0.count > $1.count })
    }
}

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

    private func showTournamentBracket() {
        let scene = tournamentSceneFactory.scene(pairsCount: firstRoundPairsCount)
        router.setRootModule(scene.view)
    }

    private func showPageView() {
        let rounds = Int(log2(Double(firstRoundPairsCount)))
        var scene = pagesSceneFactory.scene()

        for roundNumber in 0...rounds {
            let coef = Int(pow(2, Double(roundNumber)))
            let tournamentScene = tournamentSceneFactory.scene(pairsCount: firstRoundPairsCount / coef)

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

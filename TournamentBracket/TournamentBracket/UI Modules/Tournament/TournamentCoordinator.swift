//
//  TournamentCoordinator.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 07/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

fileprivate let firstRoundPairsCount = 16

final class TournamentCoordinator: Coordinatable & CoordinatorFinishable {

    private let router: Routable
    private let applicationServices: IAppServices

    private let tournamentSceneFactory: TournamentSceneFactory
    
    var finishFlow: ((Any?) -> Void)?
    
    init(router: Routable, applicationServices: IAppServices) {
        self.router = router
        self.applicationServices = applicationServices

        self.tournamentSceneFactory = TournamentSceneFactory()
    }
    
    func start() {
        showTournamentBracket()
    }

    private func showTournamentBracket() {
        let scene = tournamentSceneFactory.scene(pairsCount: firstRoundPairsCount)
        router.setRootModule(scene.view)
    }
}

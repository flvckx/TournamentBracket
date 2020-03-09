//
//  TournamentCoordinatorFactory.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 07/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

import Foundation

class TournamentCoordinatorFactory: ICoordinatorFactory {
    func create(router: Routable, services: IAppServices) -> Coordinatable & CoordinatorFinishable {
        return TournamentCoordinator(router: router, applicationServices: services)
    }
}

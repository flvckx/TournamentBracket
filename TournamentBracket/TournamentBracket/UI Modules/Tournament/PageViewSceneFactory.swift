//
//  PageViewSceneFactory.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 10/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

final class PageViewSceneFactory: SceneFactory {

    typealias Scene = (view: Presentable, viewModel: IPagesViewModel)

    func scene() -> Scene {
        let viewModel = PageViewModel()

        guard let view = R.storyboard.tournament.pageView() else {
            fatalError("Unable to initiate controller with ID: pageView")
        }
        view.viewModel = viewModel

        return (view: view, viewModel: viewModel)
    }
}

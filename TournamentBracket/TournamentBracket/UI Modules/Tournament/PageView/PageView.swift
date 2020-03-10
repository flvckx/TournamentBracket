//
//  PageView.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 10/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

import UIKit

final class PageView: UIPageViewController {

    var viewModel: PageViewModel!

    override func loadView() {
        super.loadView()
        view.backgroundColor = R.color.black()
        dataSource = viewModel
        setViewControllers([viewModel.pages.first!], direction: .forward, animated: true, completion: nil)
    }

}

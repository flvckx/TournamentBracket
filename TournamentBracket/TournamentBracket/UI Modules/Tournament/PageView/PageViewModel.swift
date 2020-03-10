//
//  PageViewModel.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 10/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

import UIKit

protocol IPagesViewModel {
    var pages: [TournamentView] { get set }
    var contentOffset: CGPoint { get set }
}

final class PageViewModel: NSObject, IPagesViewModel {

    var contentOffset: CGPoint = .zero {
        didSet {
            pages.forEach { $0.viewModel.contentOffset = contentOffset }
        }
    }

    var pages: [TournamentView] = []

}

extension PageViewModel: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let tournamentView = viewController as? TournamentView,
            let viewControllerIndex = pages.firstIndex(of: tournamentView) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return nil }
        guard pages.count > previousIndex else { return nil }

        let tournamentViewBefore = pages[previousIndex]

        return tournamentViewBefore
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let tournamentView = viewController as? TournamentView,
            let viewControllerIndex = pages.firstIndex(of: tournamentView) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let pagesCount = pages.count

        guard pagesCount != nextIndex else { return nil }
        guard pagesCount > nextIndex else { return nil }

        let tournamentViewAfter = pages[nextIndex]

        return tournamentViewAfter
    }
}

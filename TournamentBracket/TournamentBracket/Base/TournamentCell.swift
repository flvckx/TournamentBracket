//
//  TournamentCell.swift
//  TournamentBracket
//
//  Created by Serhii Palash on 09/03/2020.
//  Copyright © 2020 Serhii Palash. All rights reserved.
//

import UIKit

protocol ITournamentCell {
    var isFirstRound: Bool { get set }
    var isFirstPairGame: Bool { get set }
    var isFinal: Bool { get set }
}

class TournamentCell: UITableViewCell, ITournamentCell {

    @IBOutlet private var infoView: UIView!
    @IBOutlet private var infoViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var trailingInfoViewContstraint: NSLayoutConstraint!

    private let lineLayer = CAShapeLayer()

    var isFirstRound: Bool = true
    var isFirstPairGame: Bool = true
    var isFinal: Bool = false

    override func prepareForReuse() {
        super.prepareForReuse()
        lineLayer.removeFromSuperlayer()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpContentView()

    }

    func drawBrackets() {

        let path = UIBezierPath()

        drawLeftLink(path)
        drawRightSubLink(path)

        lineLayer.path = path.cgPath
        lineLayer.strokeColor = UIColor.white.cgColor// R.color.darkGray()?.cgColor
        lineLayer.lineWidth = 4

        contentView.layer.addSublayer(lineLayer)
    }
}

// MARK: - Private

private extension TournamentCell {

    func setUpContentView() {
        backgroundColor = R.color.black()
        infoView.backgroundColor = R.color.darkGray()
    }

    func drawLeftLink(_ path: UIBezierPath) {
        guard !isFirstRound else { return }

        path.move(to: CGPoint(x: 0, y: contentView.center.y))
        path.addLine(to: CGPoint(x: infoViewLeadingConstraint.constant, y: contentView.center.y))
    }

    func drawRightSubLink(_ path: UIBezierPath) {
        guard !isFinal else { return }

        path.move(to: CGPoint(x: contentView.frame.width - trailingInfoViewContstraint.constant, y: contentView.center.y))
        path.addLine(to: CGPoint(x: contentView.frame.width - 12, y: contentView.center.y))

        if isFirstPairGame {
            path.addCurve(
                to: CGPoint(x: contentView.frame.width - 8, y: contentView.center.y + 4),
                controlPoint1: CGPoint(x: contentView.frame.width - 10, y: contentView.center.y),
                controlPoint2: CGPoint(x: contentView.frame.width - 8, y: contentView.center.y + 2)
            )
            path.addLine(to: CGPoint(x: contentView.frame.width - 8, y: contentView.frame.height - 4))
            path.addCurve(
                to: CGPoint(x: contentView.frame.width - 4, y: contentView.frame.height),
                controlPoint1: CGPoint(x: contentView.frame.width - 8, y: contentView.frame.height - 2),
                controlPoint2: CGPoint(x: contentView.frame.width - 4, y: contentView.frame.height))
            path.addLine(to: CGPoint(x: contentView.frame.width, y: contentView.frame.height))
        } else {
            path.addCurve(
                to: CGPoint(x: contentView.frame.width - 8, y: contentView.center.y - 4),
                controlPoint1: CGPoint(x: contentView.frame.width - 10, y: contentView.center.y),
                controlPoint2: CGPoint(x: contentView.frame.width - 8, y: contentView.center.y - 2)
            )
            path.addLine(to: CGPoint(x: contentView.frame.width - 8, y: 4))
            path.addCurve(
                to: CGPoint(x: contentView.frame.width - 4, y: 0),
                controlPoint1: CGPoint(x: contentView.frame.width - 8, y: 2),
                controlPoint2: CGPoint(x: contentView.frame.width - 4, y: 0))
            path.addLine(to: CGPoint(x: contentView.frame.width, y: 0))
        }
    }
}

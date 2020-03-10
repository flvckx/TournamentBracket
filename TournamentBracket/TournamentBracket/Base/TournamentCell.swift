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

    @IBOutlet private var rightSubLayerContainer: UIView!
    @IBOutlet private var leftSubLayerContainet: UIView!

    @IBOutlet private var rightContainerWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var leftContainerWidthConstraint: NSLayoutConstraint!

    private let leftContainerLineLayer = CAShapeLayer()
    private let rightContainerLineLayer = CAShapeLayer()

    var isFirstRound: Bool = true
    var isFirstPairGame: Bool = true
    var isFinal: Bool = false

    override func prepareForReuse() {
        super.prepareForReuse()
        leftContainerLineLayer.removeFromSuperlayer()
        rightContainerLineLayer.removeFromSuperlayer()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpContentView()

    }

    func drawBrackets() {
        if !isFirstRound {
            drawLeftPath()
        }

        if !isFinal {
            drawRightPath()
        }
    }

        func drawLeftPath() {
            leftContainerLineLayer.path = drawLeftLink().cgPath
            leftContainerLineLayer.strokeColor = R.color.darkGray()?.cgColor
            leftContainerLineLayer.lineWidth = 4

            leftSubLayerContainet.layer.addSublayer(leftContainerLineLayer)
        }

        func drawRightPath() {
            rightContainerLineLayer.path = drawRightSubLink().cgPath
            rightContainerLineLayer.strokeColor = R.color.darkGray()?.cgColor
            rightContainerLineLayer.lineWidth = 4

            rightSubLayerContainer.layer.addSublayer(rightContainerLineLayer)
        }
}

// MARK: - Private

private extension TournamentCell {

    func setUpContentView() {
        backgroundColor = R.color.black()
        infoView.backgroundColor = R.color.darkGray()
    }

    func drawLeftLink() -> UIBezierPath {
        let path = UIBezierPath()

        path.move(to: CGPoint(x: 0, y: contentView.center.y))
        path.addLine(to: CGPoint(x: leftContainerWidthConstraint.constant, y: contentView.center.y))

        return path
    }

    func drawRightSubLink() -> UIBezierPath {
        let path = UIBezierPath()
        let width = rightContainerWidthConstraint.constant

        path.move(to: CGPoint(x: 0, y: contentView.center.y))
        path.addLine(to: CGPoint(x: width - 12, y: contentView.center.y))

        if isFirstPairGame {
            path.addCurve(
                to: CGPoint(x: width - 8, y: contentView.center.y + 4),
                controlPoint1: CGPoint(x: width - 10, y: contentView.center.y),
                controlPoint2: CGPoint(x: width - 8, y: contentView.center.y + 2)
            )
            path.addLine(to: CGPoint(x: width - 8, y: contentView.frame.height - 4))
            path.addCurve(
                to: CGPoint(x: width - 4, y: contentView.frame.height),
                controlPoint1: CGPoint(x: width - 8, y: contentView.frame.height - 2),
                controlPoint2: CGPoint(x: width - 4, y: contentView.frame.height))
            path.addLine(to: CGPoint(x: width, y: contentView.frame.height))
        } else {
            path.addCurve(
                to: CGPoint(x: width - 8, y: contentView.center.y - 4),
                controlPoint1: CGPoint(x: width - 10, y: contentView.center.y),
                controlPoint2: CGPoint(x: width - 8, y: contentView.center.y - 2)
            )
            path.addLine(to: CGPoint(x: width - 8, y: 4))
            path.addCurve(
                to: CGPoint(x: width - 4, y: 0),
                controlPoint1: CGPoint(x: width - 8, y: 2),
                controlPoint2: CGPoint(x: width - 4, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
        }

        return path
    }
}

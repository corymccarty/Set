//
//  SetCardView.swift
//  Set
//
//  Created by Cormac McCarty on 6/3/18.
//  Copyright © 2018 Cormac McCarty. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    var symbol = SetCard.SetSymbol.diamond { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var color = SetCard.SetSymbolColor.green { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var fill = SetCard.SetSymbolFill.solid { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var count = SetCard.SetSymbolCount.one { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isSelected = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var selectionColor = UIColor.blue { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        if isSelected {
            roundedRect.lineWidth = selectionOutlineWidth
            selectionColor.setStroke()
            roundedRect.stroke()
        }
    }
    
    private func drawDiamond(on path: UIBezierPath, in symbolBounds: CGRect) {
        // TODO: Abstract out the things that are not specific to the diamond.
        // TODO: Draw at the origin and translate using CGAfineTransform objects.
        path.move(to: symbolBounds.midLeft)
        path.addLine(to: symbolBounds.midTop)
        path.addLine(to: symbolBounds.midRight)
        path.addLine(to: symbolBounds.midBottom)
        path.addLine(to: symbolBounds.midLeft)
        path.close()
        path.lineWidth = lineWidth
        drawColor.setFill()
        drawColor.setStroke()
        let currentContext = UIGraphicsGetCurrentContext()!
        currentContext.saveGState()
        path.addClip()
        switch fill {
        case .solid: path.fill()
        case .outline: path.stroke()
        case.stripes:
            drawVerticalStripes(on: path, in: symbolBounds)
            path.stroke()
        }
        currentContext.restoreGState()
    }
    
    private func drawVerticalStripes(on path: UIBezierPath, in symbolBounds: CGRect) {
        let stripeInterval = symbolBounds.width * SizeRatio.stripesToWidth
        for xPosition in stride(from: symbolBounds.minX, to: symbolBounds.maxX, by: stripeInterval) {
            path.move(to: CGPoint(x: xPosition, y: symbolBounds.minY))
            path.addLine(to: CGPoint(x: xPosition, y: symbolBounds.maxY))
        }
    }
}

extension SetCardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let outlineWidthToBoundsHeight: CGFloat = 0.05
        static let drawingAreaToBoundsSize: CGFloat = 0.85
        static let symbolHeightToBoundsHeight = 0.25
        static let symbolWidthToBoundsWidth = 0.80
        static let stripesToWidth: CGFloat = 0.1
        static let lineWidthToBoundsHeight: CGFloat = 0.025
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var selectionOutlineWidth: CGFloat {
        return bounds.size.height * SizeRatio.outlineWidthToBoundsHeight
    }
    private var lineWidth: CGFloat {
        return bounds.size.height * SizeRatio.lineWidthToBoundsHeight
    }
    private var drawColor: UIColor {
        switch color {
        case .green: return UIColor.green
        case .red: return UIColor.red
        case .purple: return UIColor.purple
        }
    }
}

extension CGRect {
    var midLeft: CGPoint {
        return CGPoint(x: minX, y: midY)
    }
    var midTop: CGPoint {
        return CGPoint(x: midX, y: minY)
    }
    var midRight: CGPoint {
        return CGPoint(x: maxX, y: midY)
    }
    var midBottom: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }
}

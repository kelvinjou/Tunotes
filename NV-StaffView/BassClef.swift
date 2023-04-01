//
//  BassClef.swift
//  StaffClef
//
//  Created by James Bean on 6/13/16.
//
//

import Geometry
import Rendering
import Path
import UIKit

public final class BassClef: StaffClefView {
    
    public override var ornamentAltitude: Double {
        return 2 * staffSlotHeight + extenderLength
    }
    
    public override var ornament: StyledPath {

        let path0: Path = [-1,1].map { sign in
            Path.circle(
                center: Point(
                    x: 0.75 * staffSlotHeight,
                    y: ornamentAltitude + 0.8 * Double(sign) * staffSlotHeight
                ),
                radius: 0.25 * staffSlotHeight
            )
        }.sum

        let styling = Styling(fill: Fill(color: configuration.foregroundColor))
//        return StyledPath(frame: frame, path: path0, styling: styling)
        
        let path1: Path = {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0.1 * staffSlotHeight, y: 2.5 * staffSlotHeight))
            path.addCurve(to: CGPoint(x: 0.9 * staffSlotHeight, y: 2 * staffSlotHeight),
                          controlPoint1: CGPoint(x: -0.2 * staffSlotHeight, y: 3.5 * staffSlotHeight),
                          controlPoint2: CGPoint(x: 1.1 * staffSlotHeight, y: 3.5 * staffSlotHeight))

            // The middle curve
            path.addCurve(to: CGPoint(x: 0.9 * staffSlotHeight, y: -2 * staffSlotHeight),
                          controlPoint1: CGPoint(x: 1.3 * staffSlotHeight, y: 1.5 * staffSlotHeight),
                          controlPoint2: CGPoint(x: 1.3 * staffSlotHeight, y: -1.5 * staffSlotHeight))
            path.addCurve(to: CGPoint(x: 0.1 * staffSlotHeight, y: -2.5 * staffSlotHeight),
                          controlPoint1: CGPoint(x: 0.7 * staffSlotHeight, y: -2 * staffSlotHeight),
                          controlPoint2: CGPoint(x: 0.7 * staffSlotHeight, y: -2.5 * staffSlotHeight))

            // The bottom curve
            path.addCurve(to: CGPoint(x: 0.2 * staffSlotHeight, y: -2 * staffSlotHeight),
                          controlPoint1: CGPoint(x: 0.15 * staffSlotHeight, y: -2.5 * staffSlotHeight),
                          controlPoint2: CGPoint(x: 0.2 * staffSlotHeight, y: -2.25 * staffSlotHeight))
            path.addCurve(to: CGPoint(x: 0.1 * staffSlotHeight, y: -1.5 * staffSlotHeight),
                          controlPoint1: CGPoint(x: 0.2 * staffSlotHeight, y: -1.75 * staffSlotHeight),
                          controlPoint2: CGPoint(x: 0.15 * staffSlotHeight, y: -1.5 * staffSlotHeight))

            // The tail
            path.addCurve(to: CGPoint(x: -0.1 * staffSlotHeight, y: -1.5 * staffSlotHeight),
                          controlPoint1: CGPoint(x: -0.02 * staffSlotHeight, y: -2.75 * staffSlotHeight),
                          controlPoint2: CGPoint(x: -0.02 * staffSlotHeight, y: -1.25 * staffSlotHeight))
            path.addCurve(to: CGPoint(x: -0.1 * staffSlotHeight, y: 1.5 * staffSlotHeight),
                          controlPoint1: CGPoint(x: -0.18 * staffSlotHeight, y: -1.25 * staffSlotHeight),
                          controlPoint2: CGPoint(x: -0.18 * staffSlotHeight, y: 1.5 * staffSlotHeight))
            path.addCurve(to: CGPoint(x: 0.1 * staffSlotHeight, y: 1.5 * staffSlotHeight),
                          controlPoint1: CGPoint(x: -0.02 * staffSlotHeight, y: 1.5 * staffSlotHeight),
                          controlPoint2: CGPoint(x: 0, y: 1.25 * staffSlotHeight))
            
            return Path.init(path.cgPath)
           }()

           return StyledPath(frame: frame, path: path1, styling: styling)
        
//        let path: Path = {
//            let width = frame.size.width
//            let height = frame.size.height
//            let path = UIBezierPath()
//
//            // First loop
//            path.move(to: CGPoint(x: width * 0.31, y: height * 0.03))
//            path.addCurve(to: CGPoint(x: width * 0.31, y: height * 0.63),
//                          controlPoint1: CGPoint(x: width * 0.16, y: height * 0.18),
//                          controlPoint2: CGPoint(x: width * 0.16, y: height * 0.48))
//            path.addCurve(to: CGPoint(x: width * 0.51, y: height * 0.8),
//                          controlPoint1: CGPoint(x: width * 0.31, y: height * 0.75),
//                          controlPoint2: CGPoint(x: width * 0.42, y: height * 0.8))
//            path.addCurve(to: CGPoint(x: width * 0.67, y: height * 0.66),
//                          controlPoint1: CGPoint(x: width * 0.6, y: height * 0.8),
//                          controlPoint2: CGPoint(x: width * 0.67, y: height * 0.73))
//            path.addCurve(to: CGPoint(x: width * 0.56, y: height * 0.58),
//                          controlPoint1: CGPoint(x: width * 0.67, y: height * 0.61),
//                          controlPoint2: CGPoint(x: width * 0.63, y: height * 0.58))
//            path.addCurve(to: CGPoint(x: width * 0.48, y: height * 0.61),
//                          controlPoint1: CGPoint(x: width * 0.53, y: height * 0.58),
//                          controlPoint2: CGPoint(x: width * 0.51, y: height * 0.59))
//            path.addCurve(to: CGPoint(x: width * 0.43, y: height * 0.67),
//                          controlPoint1: CGPoint(x: width * 0.46, y: height * 0.62),
//                          controlPoint2: CGPoint(x: width * 0.44, y: height * 0.64))
//            path.addCurve(to: CGPoint(x: width * 0.4, y: height * 0.72),
//                          controlPoint1: CGPoint(x: width * 0.42, y: height * 0.69),
//                          controlPoint2: CGPoint(x: width * 0.41, y: height * 0.71))
//
//            // Second loop
//            path.move(to: CGPoint(x: width * 0.4, y: height * 0.34))
//            path.addCurve(to: CGPoint(x: width * 0.51, y: height * 0.44),
//                          controlPoint1: CGPoint(x: width * 0.4, y: height * 0.41),
//                          controlPoint2: CGPoint(x: width * 0.45, y: height * 0.44))
//            path.addCurve(to: CGPoint(x: width * 0.59, y: height * 0.41),
//                          controlPoint1: CGPoint(x: width * 0.54, y: height * 0.44),
//                          controlPoint2: CGPoint(x: width * 0.57, y: height * 0.43))
//            path.addCurve(to: CGPoint(x: width * 0.63, y: height * 0.34),
//                          controlPoint1: CGPoint(x: width * 0.62, y: height * 0.39),
//                          controlPoint2: CGPoint(x: width * 0.63, y: height * 0.37))
//            path.addCurve(to: CGPoint(x: width * 0.6, y: height * 0.27),
//                          controlPoint1: CGPoint(x: width * 0.63, y: height * 0.31),
//                          controlPoint2: CGPoint(x: width * 0.62, y: height * 0.29))
//            path.addCurve(to: CGPoint(x: width * 0.51, y: height * 0.25),
//                          controlPoint1: CGPoint(x: width * 0.58, y: height * 0.25),
//                          controlPoint2: CGPoint(x: width * 0.54, y: height * 0.24))
//            path.addCurve(to: CGPoint(x: width * 0.4, y: height * 0.34),
//                          controlPoint1: CGPoint(x: width * 0.43, y: height * 0.26),
//                          controlPoint2: CGPoint(x: width * 0.4, y: height * 0.3))
//
//            return Path.init(path.cgPath)
//        }()
////
//        return StyledPath(frame: frame, path: path, styling: styling)
    }
}

//
//  TrebleClef.swift
//  StaffClef
//
//  Created by James Bean on 6/13/16.
//
//
import Geometry
import Path
import Rendering
import UIKit


public final class TrebleClef: StaffClefView {
    
    public override var ornamentAltitude: Double {
        return 6 * staffSlotHeight + extenderLength
    }
    
    public override var ornament: StyledPath {
        
        let path = Path.circle(
            center: Point(x: 0, y: ornamentAltitude),
            radius: staffSlotHeight
        )
        
        let styling = Styling(
            fill: Fill(color: configuration.maskColor),
            stroke: Stroke(width: lineWidth, color: configuration.foregroundColor)
        )
        
        return StyledPath(frame: frame, path: path, styling: styling)
    }
}

public final class TenorClef: StaffClefView {
    
    public override var ornamentAltitude: Double {
        return 2 * staffSlotHeight + extenderLength
    }
    
    public override var ornament: StyledPath {
        
        let width = staffSlotHeight
        let position = Point(x: 0, y: ornamentAltitude)
        let path = Path
            .square(center: position, width: width)
            .rotated(by: Angle(degrees: 45), around: position)
        
        let styling = Styling(
            fill: Fill(color: configuration.maskColor),
            stroke: Stroke(width: lineWidth, color: configuration.foregroundColor)
        )
        
        return StyledPath(frame: frame, path: path, styling: styling)
    }
}

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
    }
    public final class AltoClef: StaffClefView {
        
        public override var ornamentAltitude: Double {
            return 4 * staffSlotHeight + extenderLength
        }
        
        public override var ornament: StyledPath {
            
            let width = staffSlotHeight
            let position = Point(x: 0, y: ornamentAltitude)
            let path = Path
                .square(center: position, width: width)
                .rotated(by: Angle(degrees: 45), around: position)
            
            let styling = Styling(
                fill: Fill(color: configuration.maskColor),
                stroke: Stroke(width: lineWidth, color: configuration.foregroundColor)
            )
            
            return StyledPath(frame: frame, path: path, styling: styling)
        }
    }
}
public final class AltoClef: StaffClefView {
    
    public override var ornamentAltitude: Double {
        return 4 * staffSlotHeight + extenderLength
    }
    
    public override var ornament: StyledPath {
        
        let width = staffSlotHeight
        let position = Point(x: 0, y: ornamentAltitude)
        let path = Path
            .square(center: position, width: width)
            .rotated(by: Angle(degrees: 45), around: position)
        
        let styling = Styling(
            fill: Fill(color: configuration.maskColor),
            stroke: Stroke(width: lineWidth, color: configuration.foregroundColor)
        )
        
        return StyledPath(frame: frame, path: path, styling: styling)
    }
}

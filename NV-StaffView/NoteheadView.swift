//
//  NoteheadView.swift
//  StaffView
//
//  Created by James Bean on 1/16/17.
//
//

import Geometry
import Path
import Rendering
import UIKit

public class NoteheadView: Renderable {
    public struct Size {

        public let staffSlotHeight: StaffSlotHeight
        public let scale: Double
        public let noteDuration: Double

        public init(staffSlotHeight: StaffSlotHeight, scale: Double = 1, noteDuration: Double = 1) {
            self.staffSlotHeight = staffSlotHeight
            self.scale = scale
            self.noteDuration = noteDuration
        }
    }
    
    public var rendered: StyledPath.Composite {
//        let styling = Styling(fill: Fill(color: Color(white: 0.5, alpha: 1)))

//        quarter note
        let styling = Styling(fill: Fill(color: Color(white: 1, alpha: 0), rule: .evenOdd), stroke: Stroke(width: 3, color: .black))
        let styledPath = StyledPath(frame: frame, path: path, styling: styling)
        let leaf: StyledPath.Composite = .leaf(.path(styledPath))
        return leaf
    }
    
    private var path: Path {
        return Path
            .ellipse(in: Rectangle(x: 0, y: 0, width: width, height: height))
            .rotated(by: Angle(degrees: 45), around: Point(x: 0.5 * width, y: 0.5 * height))
    }
    
    
    private var frame: Rectangle {
        return Rectangle(
            x: position.x - 0.5 * width,
            y: position.y - 0.5 * height,
            width: width,
            height: height
        )
    }
    
    private var width: Double {
        return 2.25 * size.staffSlotHeight * size.scale
    }
    
    private var height: Double {
        return 0.75 * width
    }
    
    public var position: Point

    public var size: Size
    
    public var noteDuration: Double
    
    // Add configuration
    public init(position: Point, size: Size, noteDuration: Double) {
        self.position = position
        self.size = size
        self.noteDuration = noteDuration
    }
}

enum NoteDuration: Int {
    case sixteenth
    case eighth
    case quarter
    case half
    case whole
}

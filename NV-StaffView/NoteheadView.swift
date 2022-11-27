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
//        public let noteDuration: Double

        public init(staffSlotHeight: StaffSlotHeight, scale: Double = 1) {
            self.staffSlotHeight = staffSlotHeight
            self.scale = scale
//            self.noteDuration = noteDuration
        }
    }
    
//    func getNote(spelling: SpelledPitch) -> Int {
//        var noteSpelling = ["c", "d", "e", "f", "g", "a", "b"]
//        for note in 0..<noteSpelling.count {
//            var letter: String = spelledNote.spelling.letterName.rawValue
//            if letter == noteSpelling[note] {
//                return note
//            }
//        }
//        return 0
//    }
    
    
    public var rendered: StyledPath.Composite {
        var pathNote: Path = path
        var noteIsWhite: Double = 0 // 0 = black, 1 = white
        
        var stemGoesUp: Bool = true
        if spelledNote.octave <= 4 {
            stemGoesUp = true
        }

        else if spelledNote.octave > 4 {
            stemGoesUp = false
        }

        
        // stem up when note is greater than B in the fourth octave
        // down down when note is equal or less than B in the fourth octave
        switch noteDuration {
//            put these note static values in some kind of tuple, it would be easier to access and it'll be less messy
        case 0.0:
            pathNote = wholeNote(stemAbove: stemGoesUp)
            noteIsWhite = 0
        case 0.25:
            pathNote = sixteenthNote(stemAbove: stemGoesUp)
            noteIsWhite = 0
        case 0.5:
            pathNote = eighthNote(stemAbove: stemGoesUp)
            noteIsWhite = 0
        case 1.5:
            pathNote = dottedQuarterNote(stemAbove: stemGoesUp)
            noteIsWhite = 0
        case 2.0:
            pathNote = halfNote(stemAbove: stemGoesUp)
            noteIsWhite = 0
        default:
            pathNote = wholeNote(stemAbove: stemGoesUp)
            noteIsWhite = 1
        }

        let styling = Styling(fill: Fill(color: Color(white: noteIsWhite, alpha: 0.8), rule: .evenOdd), stroke: Stroke(width: 3, color: .black))
        
        
        let styledPath = StyledPath(frame: frame, path: pathNote, styling: styling)

        let leaf: StyledPath.Composite = .leaf(.path(styledPath))
        return leaf
    }
    
    private var path: Path {
        return Path
            .ellipse(in: Rectangle(x: 0, y: 0, width: width, height: height))
            .rotated(by: Angle(degrees: 45), around: Point(x: 0.5 * width, y: 0.5 * height))
    }

    private func sixteenthNote(stemAbove: Bool) -> Path {

        
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 35, height: 20))

        ovalPath.apply(CGAffineTransform(rotationAngle: 30 * .pi / -180))
        ovalPath.apply(CGAffineTransform(translationX: -5, y: 10))
        
        ovalPath.move(to: CGPoint(x: 0, y: 10))
        ovalPath.addLine(to: CGPoint(x: 0, y: 110))
        
        ovalPath.move(to: CGPoint(x: 0, y: 100))
        ovalPath.addLine(to: CGPoint(x: 20, y: 95))

        ovalPath.move(to: CGPoint(x: 0, y: 110))
        ovalPath.addLine(to: CGPoint(x: 20, y: 105))
        ovalPath.apply(CGAffineTransform(rotationAngle: stemAbove ? CGFloat.pi : 0))
        ovalPath.apply(CGAffineTransform(translationX: stemAbove ? 30 : 0, y: stemAbove ? 20 : 0))
        ovalPath.close()
        return Path
            .init(ovalPath.cgPath)
    }
    
    private func eighthNote(stemAbove: Bool) -> Path {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 35, height: 20))

        ovalPath.apply(CGAffineTransform(rotationAngle: 30 * .pi / -180))
        ovalPath.apply(CGAffineTransform(translationX: -5, y: 10))
        ovalPath.move(to: CGPoint(x: 0, y: 10))
        ovalPath.addLine(to: CGPoint(x: 0, y: 110))
        ovalPath.move(to: CGPoint(x: 0, y: 110))
        ovalPath.addLine(to: CGPoint(x: 20, y: 105))
        ovalPath.apply(CGAffineTransform(rotationAngle: stemAbove ? CGFloat.pi : 0))
        ovalPath.apply(CGAffineTransform(translationX: stemAbove ? 30 : 0, y: stemAbove ? 20 : 0))
        ovalPath.close()
        return Path
            .init(ovalPath.cgPath)
    }
    private func dottedQuarterNote(stemAbove: Bool) -> Path {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 35, height: 20))
        
        ovalPath.apply(CGAffineTransform(rotationAngle: 30 * .pi / -180))
        ovalPath.apply(CGAffineTransform(translationX: -5, y: 10))
        ovalPath.move(to: CGPoint(x: 0, y: 10))
        ovalPath.addLine(to: CGPoint(x: 0, y: 110))
        ovalPath.apply(CGAffineTransform(rotationAngle: stemAbove ? CGFloat.pi : 0))
        ovalPath.apply(CGAffineTransform(translationX: stemAbove ? 30 : 0, y: stemAbove ? 20 : 0))
        ovalPath.close()
        let dotPath = UIBezierPath(ovalIn: CGRect(x: 40, y: 0, width: 5, height: 5))
        
        let combined = UIBezierPath()
        combined.append(ovalPath)
        combined.append(dotPath)
        
        return Path
            .init(combined.cgPath)
    }
    
    private func halfNote(stemAbove: Bool) -> Path {
        var ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 35, height: 20))

        ovalPath.apply(CGAffineTransform(rotationAngle: 30 * .pi / -180))
        ovalPath.apply(CGAffineTransform(translationX: -5, y: 10))
        ovalPath.move(to: CGPoint(x: 0, y: 10))
        ovalPath.addLine(to: CGPoint(x: 0, y: 110))
//        ovalPath.move(to: CGPoint(x: 0, y: 110))
//        ovalPath.addLine(to: CGPoint(x: 20, y: 105))
        ovalPath.close()
        return Path
            .init(ovalPath.cgPath)
    }
    
    private func wholeNote(stemAbove: Bool) -> Path {
        var ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 35, height: 20))
        ovalPath.apply(CGAffineTransform(rotationAngle: 30 * .pi / -180))
        ovalPath.apply(CGAffineTransform(translationX: -5, y: 10))
        return Path
            .init(ovalPath.cgPath)
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
    
    public var spelledNote: SpelledPitch
    
    // Add configuration
    public init(position: Point, size: Size, noteDuration: Double, spelledNote: SpelledPitch) {
        self.position = position
        self.size = size
        self.noteDuration = noteDuration
        self.spelledNote = spelledNote
    }
    
    enum NoteDuration {
        case sixteenth
        case eighth
        case quarter
        case half
        case whole
    }
}



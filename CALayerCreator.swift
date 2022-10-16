//
//  File.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 7/14/22.
//

import MusicScore
//import MusicSymbol
import QuartzCore
import QuartzAdapter
import SwiftUI
import Rendering
import UIKit
import Path
import Pitch

struct CALayerCreator: UIViewRepresentable {
//    @State var width: CGFloat = 0
    var selectedTrack: Int
    func makeUIView(context: Context) -> some UIView {
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2))
//          MARK: for singular composite
        let layer2 = CALayer(PremadeViews().beamsAndNoteheads(externalPitches: testAccessMeasureAndNotes(selectedTrack: selectedTrack)))
//        let layer3 = CALayer(PremadeViews().noteStem())
//        let layer2 = CALayer(PremadeViews().noteHead())
        rect.layer.addSublayer(layer2)
//        print(layer2.frame)
        
//        var width = layer2.frame.width
//        self.width = width
//        rect.layer.addSublayer(layer3)

        return rect
        
//         MARK: for multiple composites
//        for i in PremadeViews().staffLinesAndClef() {
//            let layer = CALayer(i)
//            rect.layer.addSublayer(layer)
//        }
//                return rect
        
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func testAccessMeasureAndNotes(selectedTrack: Int) -> [NoteModel] {
        
        let score = MusicScore(url: ScoreSamples.url_spring1st)!
        
        

//        var musicDuration: [NoteInScore] = []
        var noteModelArray: [NoteModel] = []
        var numberOfNotes: Int = 0
        var currentElement = 0
        for i in 0..<score.musicParts[selectedTrack].measures.count {
//            print("measure \(i)")
//        print("\t Should have", score.musicParts[0].measures[i].notes.count, "Notes")
        for i in score.musicParts[selectedTrack].measures[i].notes {
            #warning("A♯ is not matching to expected 'A', will have to only feed in the first String and have the accidental be detected by another parameter that controls sharps and flats")
//            print("Note tune", i.note.pitch.key.description)
            
            let fullDesc = i.note.pitch.key.description
            let notePitch = fullDesc[0]
            let rawAccidental = fullDesc[1]
            
            var accidental: Pitch.Spelling.Modifier = .natural
            rawAccidental.map { value in
                if value == "♯" {
                    accidental = .sharp
                }
            }
            
            var noteModel = NoteModel(spelledPitch: SpelledPitch(.b, .natural), duration: 0)

            if notePitch == Keys.c.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: .c,
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)

            }
            else if notePitch == Keys.d.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: Pitch.Spelling(.d, accidental),
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            else if notePitch == Keys.e.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: Pitch.Spelling(.e, accidental),
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            else if notePitch == Keys.f.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: Pitch.Spelling(.f, accidental),
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            else if notePitch == Keys.g.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: Pitch.Spelling(.g, accidental),
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
//                print(noteModel)
            }

            else if notePitch == Keys.a.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: Pitch.Spelling(.a, accidental),
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            else if notePitch == Keys.b.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: Pitch.Spelling(.b, accidental),
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            
            noteModelArray.append(noteModel)
            numberOfNotes += 1
            currentElement += 1
            if currentElement == score.musicParts[0].notes.count {
//                print("PitchList count: ", noteModel.spelledPitch)
                return noteModelArray
            }
        }
        }
        return []
        
    }
    
    func drawLine(position: CGFloat) -> CAShapeLayer {
        // Create a CAShapeLayer
                let shapeLayer = CAShapeLayer()

                // The Bezier path that we made needs to be converted to
                // a CGPath before it can be used on a layer.
                shapeLayer.path = drawUIBezierPath().cgPath

                // apply other properties related to the path
                shapeLayer.strokeColor = UIColor.gray.cgColor
                shapeLayer.fillColor = UIColor.white.cgColor
                shapeLayer.lineWidth = 5.0
                shapeLayer.position = CGPoint(x: position, y: 10)

                // add the new layer to our custom view
                return shapeLayer
    }
    
    func drawUIBezierPath() -> UIBezierPath {
        // create a new path
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 2, y: 100))
            path.addLine(to: CGPoint(x: 2, y: 25))
        
            return path
    }
}

struct NoteModel {
    var spelledPitch: SpelledPitch
    var duration: Double
//    var spelledNote: SpelledPitch
    
    
}

enum Keys: String, CaseIterable {
    case c = "C"
    case d = "D"
    case e = "E"
    case f = "F"
    case g = "G"
    case a = "A"
    case b = "B"
}


extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

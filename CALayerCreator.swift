//
//  File.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 7/14/22.
//

import MusicScore
import MusicSymbol
import QuartzCore
import QuartzAdapter
import SwiftUI
import Rendering
import UIKit
import Path

struct CALayerCreator: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2))
//          MARK: for singular composite
        let layer2 = CALayer(PremadeViews().beamsAndNoteheads(externalPitches: testAccessMeasureAndNotes()))
//        let layer3 = CALayer(PremadeViews().noteStem())
//        let layer2 = CALayer(PremadeViews().noteHead())
        rect.layer.addSublayer(layer2)
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
    
    func testAccessMeasureAndNotes() -> [NoteModel] {
        let score = MusicScore(url: ScoreSamples.url_spring1st)!
        
        

//        var musicDuration: [NoteInScore] = []
        var noteModelArray: [NoteModel] = []
        var currentElement = 0
        print("Should have", score.musicParts[0].measures[0].notes.count, "Notes")
        for i in score.musicParts[0].measures[0].notes {
            
            print("End beat", i.duration)
            var noteModel = NoteModel(spelledPitch: SpelledPitch(.b), duration: 0)

            if i.note.pitch.key.description == Keys.c.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: .c,
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
                
            }
            else if i.note.pitch.key.description == Keys.d.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: .d,
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            else if i.note.pitch.key.description == Keys.e.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: .e,
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            else if i.note.pitch.key.description == Keys.f.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: .f,
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            else if i.note.pitch.key.description == Keys.g.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: .g,
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            else if i.note.pitch.key.description == Keys.a.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: .a,
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            else if i.note.pitch.key.description == Keys.b.rawValue {
                noteModel = NoteModel(
                    spelledPitch: SpelledPitch(
                        spelling: .b,
                        octave: i.note.pitch.octave
                    ),
                    duration: i.duration)
            }
            
            noteModelArray.append(noteModel)
            currentElement += 1
            if currentElement == 9 {
                print("PitchList count: ", noteModel)
                return noteModelArray
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



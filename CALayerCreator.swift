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

struct CALayerCreator: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2))
//          MARK: for singular composite
//        let layer2 = CALayer(PremadeViews().beamsAndNoteheads(externalPitches: testAccessMeasureAndNotes()))
        let layer2 = CALayer(PremadeViews().noteStem())
        rect.layer.addSublayer(layer2)

        return rect
        
//         MARK: for multiple composites
//        for i in PremadeViews().staffLinesAndClef() {
//            let layer = CALayer(i)
//            rect.layer.addSublayer(layer)
//        }
        //        return rect
        
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func testAccessMeasureAndNotes() -> [SpelledPitch] {
        let score = MusicScore(url: ScoreSamples.url_spring1st)!

        

        var musicDuration: [NoteInScore] = []
        var spelledPitch: [SpelledPitch] = []
        var currentElement = 0
        print("Should have", score.musicParts[0].measures[0].notes.count, "Notes")
        for i in score.musicParts[0].measures[0].notes {
            
            print("End beat", i.duration)
            var singularPitch = SpelledPitch(.b)
            
            if i.note.pitch.key.description == Keys.c.rawValue {
                singularPitch = SpelledPitch(spelling: .c, octave: i.note.pitch.octave)
            }
            else if i.note.pitch.key.description == Keys.d.rawValue {
                singularPitch = SpelledPitch(spelling: .d, octave: i.note.pitch.octave)
            }
            else if i.note.pitch.key.description == Keys.e.rawValue {
                singularPitch = SpelledPitch(spelling: .e, octave: i.note.pitch.octave)
            }
            else if i.note.pitch.key.description == Keys.f.rawValue {
                singularPitch = SpelledPitch(spelling: .f, octave: i.note.pitch.octave)
            }
            else if i.note.pitch.key.description == Keys.f.rawValue {
                singularPitch = SpelledPitch(spelling: .f, octave: i.note.pitch.octave)
            }
            else if i.note.pitch.key.description == Keys.g.rawValue {
                singularPitch = SpelledPitch(spelling: .g, octave: i.note.pitch.octave)
            }
            else if i.note.pitch.key.description == Keys.a.rawValue {
                singularPitch = SpelledPitch(spelling: .a, octave: i.note.pitch.octave)
            }
            else if i.note.pitch.key.description == Keys.b.rawValue {
                singularPitch = SpelledPitch(spelling: .b, octave: i.note.pitch.octave)
            }
            
            spelledPitch.append(singularPitch)
            currentElement += 1
            if currentElement == 9 {
                print("PitchList count: ", singularPitch)
                return spelledPitch
            }
        }
        return []
        
    }
}

enum Keys: String {
    case c = "C"
    case d = "D"
    case e = "E"
    case f = "F"
    case g = "G"
    case a = "A"
    case b = "B"
}



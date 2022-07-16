//
//  File.swift
//  CorrectSwiftPMFormat
//
//  Created by Kelvin J on 7/14/22.
//
import SwiftUI
import Pitch
import Duration
import Foundation
import MusicModel
import Rendering
import Geometry



class PremadeViews {
    func noteHead() -> StyledPath.Composite {
        var notehead = NoteheadView(position: .zero, size: NoteheadView.Size(staffSlotHeight: 40, scale: 2)).rendered
//        var noteHead2 = NoteheadView(position: .zero, size: NoteVi)
        return notehead
    }
    func noteView() {
        
    }
    
    func flat() -> StyledPath.Composite {
        var flat = Sharp(position: Point(x: 0, y: 300), size: StaffItemSize(staffSlotHeight: StaffSlotHeight(5), scale: 2), color: .black).rendered
        return flat
    }
    
    func staffLinesAndClef() -> [StyledPath.Composite] {
        let clefs: [Clef.Kind] = [.tenor]
        var currentElement = 0
        
        var renderedViews = [StyledPath.Composite]()
        
        for clef in clefs {
            let builder = StaffView.Builder(clef: Clef(clef), configuration: StaffConfiguration())
            builder.startLines(at: 0)
            builder.stopLines(at: 500)
            let staffView = builder.build()
            
            renderedViews.append(staffView.rendered)
            currentElement += 1
        }
        if currentElement == clefs.count {
            return renderedViews
        }
        return []
    }
    
    func staffWithLinesNoteheadsAndClef() -> StyledPath.Composite {
        let pitches: [Pitch] = [60, 62, 63, 64, 66, 68, 71]
        let spelled = pitches.map { $0.spelledWithDefaultSpelling }
        let representable = spelled.map { StaffRepresentablePitch($0) }
        let points = representable.map { StaffPointModel([$0]) }
        let positions = (0..<pitches.count).map { Double($0) * 100 + 100 }
        let builder = StaffModel.builder
        zip(positions, points).forEach { position, point in builder.add(point, at: position) }
        let model = builder.build()
        
        let staff = StaffView.Builder(model: model, configuration: StaffConfiguration()).build()
        
        return staff.rendered
    }
    
    func beamsAndNoteheads(externalPitches: [SpelledPitch]) -> StyledPath.Composite {
//        let rhythm = Rhythm(1/>4, [(4,event(())),(2,event(())),(1,event(())),(2,event(()))])
//        let beaming = DefaultBeamer.beaming(for: rhythm)
//        let configuration = BeamsView.Configuration(slope: -0.125)
//        let beamsView = BeamsView(
//                beaming: beaming,
//                positions: [100, 200, 300, 400],
//                configuration: configuration
//        )
        
//        let pitches: [Pitch] = [60, 62, 63, 64, 66, 68, 83]
//        let spelled = pitches.map { $0.spelledWithDefaultSpelling }
        let representable = externalPitches.map { StaffRepresentablePitch($0) }
        let points = representable.map { StaffPointModel([$0]) }
        
        let positions = (0..<externalPitches.count).map { Double($0) * 100 + 100 }
        let builder = StaffModel.builder
        zip(positions, points).forEach { position, point in builder.add(point, at: position) }
        
        let model = builder.build()
        let staff = StaffView(model: model)
        
        let newBeam = Beam(start: Point(x: 1, y: 1), end: Point(x: 2, y: 2), width: 1)
        let score = ScoreView(beams: BeamsView(beams: [newBeam], color: .black), staff: staff).rendered.resizedToFitContents
        
        return score
    
    }
    
    func beamStraight() -> StyledPath.Composite {
        let beam = Beam(start: Point(x: 20, y: 20), end: Point(x: 100, y: 20), width: 10)
        let beamsView = BeamsView(beams: [beam], color: .black).rendered.resizedToFitContents
        
        return beamsView
    }
    
    func plotModel() -> DefaultVerticalPlotModel {
        let values: [Double : Double] = [0: 1, 30: 0.5, 60: 0.75, 90: 0.25, 300: 1, 325: 0]
        let builder = DefaultVerticalPlotModel.Builder()
        
        for (position, value) in values {
            let point = DefaultVerticalPointModel(value)
            builder.add(point, at: position)
        }
        
        let plot = builder.build()
        return plot
    }
    
    func noteStem() -> StyledPath.Composite {
        let pitches: [Pitch] = [64]
        let spelled = pitches.map { $0.spelledWithDefaultSpelling }
        let representable = spelled.map { StaffRepresentablePitch($0) }
        let points = representable.map { StaffPointModel([$0]) }
        
        let noteWithStem = representable.map {
            
            StaffPointModel([$0]).stemConnectionPoint(from: VerticalDirection.above, axis: Clef(.treble))
            
        }
        
        print(noteWithStem)
        
        
        let positions = (0..<pitches.count).map { Double($0) * 100 + 100 }
        let builder = StaffModel.builder
//        TODO: noteWithStem returns [StaffSlot] and not [StaffPointModel]
        zip(positions, points).forEach { position, point in
            builder.add(point, at: position)
            
//            builder.add(point, at: Double(noteWithStem[0]!) + 100)
            
        }
        let model = builder.build()
        
        let staff = StaffView.Builder(model: model, configuration: StaffConfiguration()).build()
        
        return staff.rendered
    }
}

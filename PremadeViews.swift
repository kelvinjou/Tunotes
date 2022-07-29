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
        let notehead = NoteheadView(position: .zero, size: NoteheadView.Size(staffSlotHeight: 40, scale: 2), noteDuration: 1)
        return notehead.rendered
    }
    
    func flat() -> StyledPath.Composite {
        let flat = Sharp(position: Point(x: 0, y: 300), size: StaffItemSize(staffSlotHeight: StaffSlotHeight(5), scale: 2), color: .black).rendered
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
        let representable = spelled.map { StaffRepresentablePitch($0, .ord) }
//        Notehead
        let points = representable.map { StaffPointModel([$0]) }
        let positions = (0..<pitches.count).map { Double($0) * 100 + 100 }
        let builder = StaffModel.builder
        zip(positions, points).forEach { position, point in
//            point.stemConnectionPoint(from: .above, axis: Clef(.treble))
            builder.add(point, at: position, noteDuration: 87)

        }
        
        let model = builder.build()
        
        let staff = StaffView.Builder(model: model, configuration: StaffConfiguration()).build()
        return staff.rendered
    }
    
    func beamsAndNoteheads(externalPitches: [NoteModel]) -> StyledPath.Composite {
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
//        print(externalPitches)
        
        #warning("external pitch has 0 values")
        let representable = externalPitches.map {
            StaffRepresentablePitch($0.spelledPitch)
        }


        let points = representable.map { StaffPointModel([$0]) }
        let positions = (0..<externalPitches.count).map { Double($0) * 100 + 100 }

        let builder = StaffModel.builder
        
//        var noteStemArray: [NoteheadView] = []
        for (position, point, i) in zip3(positions, points, 0..<points.count) {
            builder.add(point, at: position, noteDuration: externalPitches[i].duration)
            
//            noteStemArray.append(NoteheadView(position: StaffModel, size: .init(staffSlotHeight: 40), noteDuration: externalPitches[i].duration))
            
            print("index:", i, "at", externalPitches[i].duration)
        }
        
        let model = builder.build()
        let staff = StaffView(model: model)
        let newBeam = Beam(start: Point(x: 1, y: 1), end: Point(x: 2, y: 2), width: 1)
//        let newBeam = Beam(start: Point(x: 0, y: 0), end: Point(x: 0, y: -100), width: 5)
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
    
    
    func rhythmView() -> StyledPath.Composite {
        let configuration = BeamsView.Configuration(orientation: .stemsDown, slope: -0.125)
        let beamsView = BeamsView(
            beaming: Beaming(beamCounts: [1, 2, 3, 3]),
            positions: [100, 200, 300, 400],
            configuration: configuration
        )
        let rhy = RhythmView(beamsView: beamsView)
        return rhy.rendered
    }
    
}


struct Zip3Sequence<E1, E2, E3>: Sequence, IteratorProtocol {
    private let _next: () -> (E1, E2, E3)?

    init<S1: Sequence, S2: Sequence, S3: Sequence>(_ s1: S1, _ s2: S2, _ s3: S3) where S1.Element == E1, S2.Element == E2, S3.Element == E3 {
        var it1 = s1.makeIterator()
        var it2 = s2.makeIterator()
        var it3 = s3.makeIterator()
        _next = {
            guard let e1 = it1.next(), let e2 = it2.next(), let e3 = it3.next() else { return nil }
            return (e1, e2, e3)
        }
    }

    mutating func next() -> (E1, E2, E3)? {
        return _next()
    }
}

extension PremadeViews {
    func zip3<S1: Sequence, S2: Sequence, S3: Sequence>(_ s1: S1, _ s2: S2, _ s3: S3) -> Zip3Sequence<S1.Element, S2.Element, S3.Element> {
        return Zip3Sequence(s1, s2, s3)
    }
}
